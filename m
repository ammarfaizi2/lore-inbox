Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUBHGe6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 01:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUBHGe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 01:34:58 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:10741 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262564AbUBHGe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 01:34:56 -0500
Date: Sat, 7 Feb 2004 22:34:47 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Francis, Chong Chan Fai" <francis.ccf@polyu.edu.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 mass storage problem
Message-ID: <20040208063447.GB18674@srv-lnx2600.matchmail.com>
Mail-Followup-To: "Francis, Chong Chan Fai" <francis.ccf@polyu.edu.hk>,
	linux-kernel@vger.kernel.org
References: <200402080610.i186AEp19152@mailgate01.ctimail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402080610.i186AEp19152@mailgate01.ctimail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 02:11:23PM +0800, Francis, Chong Chan Fai wrote:
> Hi,
> 
> I have my laptop installed with Fedora Core (Kernel 2.4.22), and I want to
> use a USB 2.0 120G hard drive via a Cardbus USB2.0 adaptor.
> I plug the Cardbus card, and then the USB2.0 HD, (after a few config) linux
> recognize my HD and I can use mount /dev/sda1 /mnt/extra to mount it.
> 
> HOWEVER, the disk fail after a few read or write operation. From error log:
> Feb  8 12:57:15 wind kernel: SCSI device sda: 234441648 512-byte hdwr
> sectors (120034 MB) Feb  8 12:57:15 wind kernel: sda: assuming drive cache:
> write through Feb  8 12:57:16 wind kernel:  sda: sda1 sda2 < sda5 > Feb  8
> 12:57:16 wind kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun
> 0 Feb  8 12:57:16 wind kernel: EXT2-fs warning: mounting unchecked fs,
> running e2fsck is recommended Feb  8 13:13:40 wind kernel: SCSI error : <0 0
> 0 0> return code = 0x6000000 Feb  8 13:13:40 wind kernel: end_request: I/O
> error, dev sda, sector 76276607 Feb  8 13:15:30 wind kernel: SCSI error : <0
> 0 0 0> return code = 0x6000000 Feb  8 13:15:30 wind kernel: end_request: I/O
> error, dev sda, sector 76276615

Probably a problem with pcmcia.

I've used a usb 2.0 pci card, but the cpu usage is so high that it's just as
fast as the same card using the uhci-hcd driver -- and uhci uses *much*
less cpu.

This is with 2.6.1-bk2.
