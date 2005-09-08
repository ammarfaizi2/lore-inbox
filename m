Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbVIHWwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbVIHWwc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbVIHWwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:52:32 -0400
Received: from mail0.lsil.com ([147.145.40.20]:48048 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S965063AbVIHWwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:52:31 -0400
Message-ID: <91888D455306F94EBD4D168954A9457C03F495CC@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: mike.miller@hp.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Cc: axboe@suse.de, akpm@osdl.org
Subject: RE: can't boot 2.6.13
Date: Thu, 8 Sep 2005 16:51:45 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 08, 2005 3:19 PM, Mike Miller(HP) wrote:
> I am not able to boot the 2.6.13 version of the kernel. I've 
> tried different systems, tried downloading again, still 
> nothing. Here's the last thing I see from the serial port:
> 
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> RAMDISK: Compressed image found at block 0
> input: AT Translated Set 2 keyboard on isa0060/serio0
> VFS: Mounted root (ext2 filesystem).
> logips2pp: Detected unknown logitech mouse model 1
> input: PS/2 Logitech Mouse on isa0060/serio1
> SCSI subsystem initialized
> Fusion MPT base driver 3.03.02
> Copyright (c) 1999-2005 LSI Logic Corporation
> 

We introduced split drivers for 2.6.13.  There are new layer drivers
that sit ontop of mptscsih.ko.  These drivers are split along bus
protocal, so there is mptspi.ko, mptfc.ko, and mptsas.ko.  This is
to tie into the scsi transport layers that are split the same.

For 1030(a SPI controller)
If your using RedHat, you need to change mptscish to mptspi in
/etc/modprobe.conf.
If your using SuSE, you need to change mptscish to mptspi in
/etc/sysconfig/kernel

