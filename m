Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVJ2UP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVJ2UP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVJ2UP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:15:56 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:15205 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751239AbVJ2UPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:15:55 -0400
Message-ID: <20051029201554.21460.qmail@web31813.mail.mud.yahoo.com>
X-RocketYMMF: ltuikov
Date: Sat, 29 Oct 2005 13:15:54 -0700 (PDT)
From: Luben Tuikov <luben_tuikov@adaptec.com>
Reply-To: luben_tuikov@adaptec.com
Subject: Re: 2.6.14-rc5-mm1: SAS: compile error with gcc 2.95
To: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20051029195947.GM4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Adrian Bunk <bunk@stusta.de> wrote:

> On Mon, Oct 24, 2005 at 01:48:38AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.14-rc4-mm1:
> >...
> >  git-sas.patch
> >...
> >  Subsystem trees
> >...
> 
> This gives the following compile error with gcc 2.95:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/scsi/aic94xx/aic94xx_init.o
> In file included from include/scsi/sas/sas.h:90,
>                  from include/scsi/sas/sas_class.h:33,
>                  from include/scsi/sas/sas_discover.h:29,
>                  from drivers/scsi/aic94xx/aic94xx.h:33,
>                  from drivers/scsi/aic94xx/aic94xx_init.c:36:
> include/scsi/sas/sas_frames.h:46: warning: unnamed struct/union that defines
> no instances
> include/scsi/sas/sas_frames.h:47: warning: unnamed struct/union that defines
> no instances
> include/scsi/sas/sas_frames.h:55: warning: unnamed struct/union that defines
> no instances
> include/scsi/sas/sas_frames.h:70: warning: unnamed struct/union that defines
> no instances
> include/scsi/sas/sas_frames.h:71: warning: unnamed struct/union that defines
> no instances
> include/scsi/sas/sas_frames.h:79: warning: unnamed struct/union that defines
> no instances
> In file included from include/scsi/sas/sas_frames.h:90,
>                  from include/scsi/sas/sas.h:90,
>                  from include/scsi/sas/sas_class.h:33,
>                  from include/scsi/sas/sas_discover.h:29,
>                  from drivers/scsi/aic94xx/aic94xx.h:33,
>                  from drivers/scsi/aic94xx/aic94xx_init.c:36:
> include/scsi/sas/sas_frames_le.h:51: warning: unnamed struct/union that
> defines no instances
> include/scsi/sas/sas_frames_le.h:53: warning: unnamed struct/union that
> defines no instances
> include/scsi/sas/sas_frames_le.h:63: warning: unnamed struct/union that
> defines no instances
> include/scsi/sas/sas_frames_le.h:65: warning: unnamed struct/union that
> defines no instances
> include/scsi/sas/sas_frames_le.h:219: warning: unnamed struct/union that
> defines no instances
> In file included from drivers/scsi/aic94xx/aic94xx.h:33,
>                  from drivers/scsi/aic94xx/aic94xx_init.c:36:
> include/scsi/sas/sas_discover.h:157: warning: unnamed struct/union that
> defines no instances
> include/scsi/sas/sas_discover.h: In function `sas_init_dev':
> include/scsi/sas/sas_discover.h:201: structure has no member named `end_dev'
> include/scsi/sas/sas_discover.h:201: structure has no member named `end_dev'
> include/scsi/sas/sas_discover.h:201: structure has no member named `end_dev'
> include/scsi/sas/sas_discover.h:201: structure has no member named `end_dev'
> include/scsi/sas/sas_discover.h:205: structure has no member named `ex_dev'
> include/scsi/sas/sas_discover.h:205: structure has no member named `ex_dev'
> include/scsi/sas/sas_discover.h:205: structure has no member named `ex_dev'
> include/scsi/sas/sas_discover.h:205: structure has no member named `ex_dev'
> include/scsi/sas/sas_discover.h:210: structure has no member named `sata_dev'
> include/scsi/sas/sas_discover.h:210: structure has no member named `sata_dev'
> include/scsi/sas/sas_discover.h:210: structure has no member named `sata_dev'
> include/scsi/sas/sas_discover.h:210: structure has no member named `sata_dev'
> In file included from drivers/scsi/aic94xx/aic94xx_hwi.h:36,
>                  from drivers/scsi/aic94xx/aic94xx_reg.h:32,
>                  from drivers/scsi/aic94xx/aic94xx_init.c:37:
> drivers/scsi/aic94xx/aic94xx_sas.h: At top level:
> drivers/scsi/aic94xx/aic94xx_sas.h:363: warning: unnamed struct/union that
> defines no instances
> drivers/scsi/aic94xx/aic94xx_sas.h:643: warning: unnamed struct/union that
> defines no instances
> make[3]: *** [drivers/scsi/aic94xx/aic94xx_init.o] Error 1
> 
> <--  snip  -->
> 
> Since gcc 2.95 is a supported compiler for 2.6, the code has to be 
> changed to compile with gcc 2.95.

Yes, I've been meaning to add names to unions to fix compilation with
gcc 2.95 for some time now.  Andrew has pointed that out to me before.

I'll submit a patch shortly.

     Luben


-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
