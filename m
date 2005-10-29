Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVJ2T7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVJ2T7u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 15:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVJ2T7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 15:59:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43784 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932066AbVJ2T7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 15:59:49 -0400
Date: Sat, 29 Oct 2005 21:59:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Luben Tuikov <luben_tuikov@adaptec.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: 2.6.14-rc5-mm1: SAS: compile error with gcc 2.95
Message-ID: <20051029195947.GM4180@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 01:48:38AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.14-rc4-mm1:
>...
>  git-sas.patch
>...
>  Subsystem trees
>...

This gives the following compile error with gcc 2.95:

<--  snip  -->

...
  CC      drivers/scsi/aic94xx/aic94xx_init.o
In file included from include/scsi/sas/sas.h:90,
                 from include/scsi/sas/sas_class.h:33,
                 from include/scsi/sas/sas_discover.h:29,
                 from drivers/scsi/aic94xx/aic94xx.h:33,
                 from drivers/scsi/aic94xx/aic94xx_init.c:36:
include/scsi/sas/sas_frames.h:46: warning: unnamed struct/union that defines no instances
include/scsi/sas/sas_frames.h:47: warning: unnamed struct/union that defines no instances
include/scsi/sas/sas_frames.h:55: warning: unnamed struct/union that defines no instances
include/scsi/sas/sas_frames.h:70: warning: unnamed struct/union that defines no instances
include/scsi/sas/sas_frames.h:71: warning: unnamed struct/union that defines no instances
include/scsi/sas/sas_frames.h:79: warning: unnamed struct/union that defines no instances
In file included from include/scsi/sas/sas_frames.h:90,
                 from include/scsi/sas/sas.h:90,
                 from include/scsi/sas/sas_class.h:33,
                 from include/scsi/sas/sas_discover.h:29,
                 from drivers/scsi/aic94xx/aic94xx.h:33,
                 from drivers/scsi/aic94xx/aic94xx_init.c:36:
include/scsi/sas/sas_frames_le.h:51: warning: unnamed struct/union that defines no instances
include/scsi/sas/sas_frames_le.h:53: warning: unnamed struct/union that defines no instances
include/scsi/sas/sas_frames_le.h:63: warning: unnamed struct/union that defines no instances
include/scsi/sas/sas_frames_le.h:65: warning: unnamed struct/union that defines no instances
include/scsi/sas/sas_frames_le.h:219: warning: unnamed struct/union that defines no instances
In file included from drivers/scsi/aic94xx/aic94xx.h:33,
                 from drivers/scsi/aic94xx/aic94xx_init.c:36:
include/scsi/sas/sas_discover.h:157: warning: unnamed struct/union that defines no instances
include/scsi/sas/sas_discover.h: In function `sas_init_dev':
include/scsi/sas/sas_discover.h:201: structure has no member named `end_dev'
include/scsi/sas/sas_discover.h:201: structure has no member named `end_dev'
include/scsi/sas/sas_discover.h:201: structure has no member named `end_dev'
include/scsi/sas/sas_discover.h:201: structure has no member named `end_dev'
include/scsi/sas/sas_discover.h:205: structure has no member named `ex_dev'
include/scsi/sas/sas_discover.h:205: structure has no member named `ex_dev'
include/scsi/sas/sas_discover.h:205: structure has no member named `ex_dev'
include/scsi/sas/sas_discover.h:205: structure has no member named `ex_dev'
include/scsi/sas/sas_discover.h:210: structure has no member named `sata_dev'
include/scsi/sas/sas_discover.h:210: structure has no member named `sata_dev'
include/scsi/sas/sas_discover.h:210: structure has no member named `sata_dev'
include/scsi/sas/sas_discover.h:210: structure has no member named `sata_dev'
In file included from drivers/scsi/aic94xx/aic94xx_hwi.h:36,
                 from drivers/scsi/aic94xx/aic94xx_reg.h:32,
                 from drivers/scsi/aic94xx/aic94xx_init.c:37:
drivers/scsi/aic94xx/aic94xx_sas.h: At top level:
drivers/scsi/aic94xx/aic94xx_sas.h:363: warning: unnamed struct/union that defines no instances
drivers/scsi/aic94xx/aic94xx_sas.h:643: warning: unnamed struct/union that defines no instances
make[3]: *** [drivers/scsi/aic94xx/aic94xx_init.o] Error 1

<--  snip  -->

Since gcc 2.95 is a supported compiler for 2.6, the code has to be 
changed to compile with gcc 2.95.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

