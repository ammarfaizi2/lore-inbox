Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVAIGFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVAIGFn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 01:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVAIGFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 01:05:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53770 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262260AbVAIGFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 01:05:36 -0500
Date: Sun, 9 Jan 2005 07:05:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_SCSI_QLA2<tripleX> looks dead - could it be removed ?
Message-ID: <20050109060531.GN14108@stusta.de>
References: <5a4c581d050108214866117e3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d050108214866117e3a@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 06:48:41AM +0100, Alessandro Suardi wrote:

> Hoping that this time the gmail filter doesn't bounce my subject (doh)
> 
> Said entry only appears in defconfigs, but doesn't seem to be actually
> used by anyone - at least according to this grep:
> 
> [asuardi@incident linux]$ find . -type f | xargs grep
> CONFIG_SCSI_QLA2XXX | grep -v defconfig

Correct grep command:
   grep -r SCSI_QLA2XXX * | grep -v defconfig

> ./drivers/scsi/Makefile:obj-$(CONFIG_SCSI_QLA2XXX)      += qla2xxx/
> ./include/linux/autoconf.h:#define CONFIG_SCSI_QLA2XXX_MODULE 1
> ./.config:CONFIG_SCSI_QLA2XXX=m
> ./.config.old:CONFIG_SCSI_QLA2XXX=m
> [asuardi@incident linux]$
> 
> Moreover, there doesn't seem to be any entry in kbuild menus to
>  turn it off. Even taking it out of my .config and running oldconfig
>  brings it back in.

You missed drivers/scsi/qla2xxx/Kconfig .

> --alessandro

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

