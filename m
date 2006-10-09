Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWJIVEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWJIVEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 17:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWJIVEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 17:04:51 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:60047 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S964863AbWJIVEu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 17:04:50 -0400
Message-ID: <452AB97B.5040309@drzeus.cx>
Date: Mon, 09 Oct 2006 23:04:59 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: pHilipp Zabel <philipp.zabel@gmail.com>
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use own work queue
References: <20061001124240.16996.34557.stgit@poseidon.drzeus.cx> <74d0deb30610070717k17079940ybedbf94dc8af8460@mail.gmail.com>
In-Reply-To: <74d0deb30610070717k17079940ybedbf94dc8af8460@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pHilipp Zabel wrote:
> 
> This patch makes pxamci stop working for me on a HTC Magician (PXA272).
> Switching from 2.6.18 to 2.6.19-rc1 I got a kernel panic:
> 
> mmc0: clock 0Hz busmode 1 powermode 0 cs 0  Vdd 0 width 0
> PXAMCI: clkrt = 0 cmdat = 0
> VFS: Cannot open root device "mmcblk0p2" or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
> 
> After removing this patch from 2.6.19-rc1, everything is working again.
> Are there any changes to pxamci.c needed to be compatible with it?
> 

No, the drivers shouldn't be affected. As this is a root device, my
guess would be that you have a race in your bootup that is causing problem.

Are you using initrd for this device? And could you get a complete dmesg
dump?

Rgds
Pierre
