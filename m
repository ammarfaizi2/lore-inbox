Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVIHXYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVIHXYF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 19:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVIHXYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 19:24:05 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:24469 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S965045AbVIHXYE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 19:24:04 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: can't boot 2.6.13
Date: Thu, 8 Sep 2005 18:23:59 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10AC92126@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: can't boot 2.6.13
Thread-index: AcW0x+/ULQBd7l6oQYmVgvc7RjjjsAABFnqQ
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Cc: <axboe@suse.de>, <akpm@osdl.org>
X-OriginalArrivalTime: 08 Sep 2005 23:24:00.0374 (UTC) FILETIME=[6494F960:01C5B4CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Eric.
Anyone have any ideas why my cciss based system won't boot?

mikem 

> -----Original Message-----
> From: Moore, Eric Dean [mailto:Eric.Moore@lsil.com] 
> Sent: Thursday, September 08, 2005 5:52 PM
> To: Miller, Mike (OS Dev); linux-kernel@vger.kernel.org; 
> linux-scsi@vger.kernel.org
> Cc: axboe@suse.de; akpm@osdl.org
> Subject: RE: can't boot 2.6.13
> 
> On Thursday, September 08, 2005 3:19 PM, Mike Miller(HP) wrote:
> > I am not able to boot the 2.6.13 version of the kernel. I've tried 
> > different systems, tried downloading again, still nothing. 
> Here's the 
> > last thing I see from the serial port:
> > 
> > md: Autodetecting RAID arrays.
> > md: autorun ...
> > md: ... autorun DONE.
> > RAMDISK: Compressed image found at block 0
> > input: AT Translated Set 2 keyboard on isa0060/serio0
> > VFS: Mounted root (ext2 filesystem).
> > logips2pp: Detected unknown logitech mouse model 1
> > input: PS/2 Logitech Mouse on isa0060/serio1 SCSI subsystem 
> > initialized Fusion MPT base driver 3.03.02 Copyright (c) 
> 1999-2005 LSI 
> > Logic Corporation
> > 
> 
> We introduced split drivers for 2.6.13.  There are new layer 
> drivers that sit ontop of mptscsih.ko.  These drivers are 
> split along bus protocal, so there is mptspi.ko, mptfc.ko, 
> and mptsas.ko.  This is to tie into the scsi transport layers 
> that are split the same.
> 
> For 1030(a SPI controller)
> If your using RedHat, you need to change mptscish to mptspi 
> in /etc/modprobe.conf.
> If your using SuSE, you need to change mptscish to mptspi in 
> /etc/sysconfig/kernel
> 
> 
