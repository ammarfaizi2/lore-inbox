Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVE3WnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVE3WnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVE3WnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:43:23 -0400
Received: from smtp04.auna.com ([62.81.186.14]:56976 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S261801AbVE3WmI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:42:08 -0400
Date: Mon, 30 May 2005 22:42:06 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [RFT][PATCH] aic79xx: remove busyq
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20050529074620.GA26151@havoc.gtf.org>
	<1117488507l.7621l.0l@werewolf.able.es> <429B9311.9000608@pobox.com>
In-Reply-To: <429B9311.9000608@pobox.com> (from jgarzik@pobox.com on Tue May
	31 00:26:25 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1117492926l.11695l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.79] Login:jamagallon@able.es Fecha:Tue, 31 May 2005 00:42:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.31, Jeff Garzik wrote:
> J.A. Magallon wrote:
> > On 05.29, Jeff Garzik wrote:
> > 
> >>Can anyone with aic79xx hardware give me a simple "it works"
> >>or "this breaks things" answer, for the patch below?
> >>
> >>This changes the aic79xx driver to use the standard Linux SCSI queueing
> >>code, rather than its own.  After applying this patch, NO behavior
> >>changes should be seen.
> >>
> >>The patch is against 2.6.12-rc5, but probably applies OK to recent 2.6.x
> >>kernels.
> >>
> > 
> > 
> > Applied with even no offsets to -rc5-mm1. Booted and working fine:
> 
> Thanks a bunch!
> 

Ooops, I forgot...

  CC      drivers/scsi/aic7xxx/aic7xxx_osm_pci.o
drivers/scsi/aic7xxx/aic7xxx_osm.c: In function 'ahc_linux_register_host':
drivers/scsi/aic7xxx/aic7xxx_osm.c:1205: warning: ignoring return value of
'scsi_add_host', declared with attribute warn_unused_result



--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam20 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


