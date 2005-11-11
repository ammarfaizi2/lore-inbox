Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVKKGHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVKKGHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 01:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVKKGHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 01:07:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50066 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932209AbVKKGHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 01:07:48 -0500
Date: Thu, 10 Nov 2005 22:07:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm2
Message-Id: <20051110220727.13b084f4.akpm@osdl.org>
In-Reply-To: <43743105.7030201@reub.net>
References: <20051110203544.027e992c.akpm@osdl.org>
	<43743105.7030201@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> Hi,
> 
> On 11/11/2005 5:35 p.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/
> > 
> > - reiser4 seems to be broken when built as a module (due, I assume, to a
> >   reiser4-specific kbuild change).  CONFIG_REISER4_FS=y will be needed.
> > 
> > - New git tree git-cfq.patch - CFQ I/O scheduler updates from Jens
> > 
> > - The git-pcmcia tree has been reinstated
> > 
> > - git-audit and the several -mm fixups to it have been dropped for now - it's
> >   undergoing a bit of churn.
> > 
> > - Numerous subsystem updates.  Notably more v4l work.
> 
> Network is a no-go for me:
> 
> [root@tornado ~]# /etc/init.d/network restart
> e100: 0000:06:03.0: e100_eeprom_load: EEPROM corrupted
> e100: probe of 0000:06:03.0 failed with error -11
> sky2 0000:04:00.0: unsupported chip type 0xff
> sky2: probe of 0000:04:00.0 failed with error -95

At a guess I'd say we didn't power the NIC up.

Could you please generate full dmesg output for good and bad kernels?

Also `lspci -vvxx -s 06:03.0' to have a look at the card's config space.

> Both drivers worked under 2.6.14-rc5-mm1, but failed with 2.6.14-mm2.  I also 
> re-tested against 2.6.14-mm1 and this problem also occurs there (I didn't get 
> to test this this far with -mm1, had too many problems with other things and 
> been having other hassles such as dsl connection).

Are you able to test just
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/broken-out/linus.patch ?

> Somehow I doubt that these two cards are both genuinely faulty..........I can 
> swap out with another e100 if need be.

Yeah.   You could try eepro100.c, perhaps.


