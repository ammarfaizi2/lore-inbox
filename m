Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVHDU1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVHDU1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVHDUYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:24:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37506 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262643AbVHDUXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:23:33 -0400
Date: Thu, 4 Aug 2005 13:25:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Fieroch <Fieroch@web.de>
Cc: jesper.juhl@gmail.com, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com,
       linux-kernel@vger.kernel.org, axboe@suse.de,
       B.Zolnierkiewicz@elka.pw.edu.pl, adobriyan@gmail.com,
       Natalie.Protasevich@UNISYS.com
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:
 nobody cared!"
Message-Id: <20050804132516.2f468522.akpm@osdl.org>
In-Reply-To: <42C0953B.8000506@web.de>
References: <d6gf8j$jnb$1@sea.gmane.org>
	<20050527171613.5f949683.akpm@osdl.org>
	<429A2397.6090609@web.de>
	<58cb370e05061401041a67cfa7@mail.gmail.com>
	<42B091EE.4020802@web.de>
	<20050615143039.24132251.akpm@osdl.org>
	<1118960606.24646.58.camel@localhost.localdomain>
	<42B2AACC.7070908@web.de>
	<1119011887.24646.84.camel@localhost.localdomain>
	<42B302C2.9030009@web.de>
	<9a874849050617101712b80b15@mail.gmail.com>
	<42C0953B.8000506@web.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Fieroch <Fieroch@web.de> wrote:
>
> The problem still occurs in kernel 2.6.12-mm2.
> 
> Now there are two modules for IT8212 in the kernel: 
> CONFIG_BLK_DEV_IT821X and CONFIG_SCSI_ITERAID
> 
> Running the mm2 kernel with "ITE IT8212 RAID CARD support" enabled and 
> compiled into the kernel I get a kernel panic:
> 
> VFS: Cannot open root device "sda3" or unknown-block(8,3)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on 
> unknown-block(8,3)
> 
> sda3 is a SATA drive with the root partition and linux is booting 
> without CONFIG_SCSI_ITERAID enabled in the kernel. Is there a conflict 
> with the sata driver?
> 

I dropped iteraid.patch

> Having compiled "IT821X IDE support" into the kernel but not "ITE IT8212 
> RAID CARD support" the errors still occur. The complete syslog with 
> kernel options pci=routeirq and apic=debug is attached.

OK, that's the driver which Alan played with.  I don't expect we'll be able
to get all this fixed up for 2.6.13.

Please check 2.6.13-rc6 when it's out - this might fix the IRQ problem.  If
any bugs remain, please raise entries for them at bugzilla.kernel.org,
thanks.

