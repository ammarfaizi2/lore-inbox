Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266782AbUHURPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266782AbUHURPv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 13:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266790AbUHURPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 13:15:51 -0400
Received: from aun.it.uu.se ([130.238.12.36]:19152 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266768AbUHURPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 13:15:47 -0400
Date: Sat, 21 Aug 2004 19:15:36 +0200 (MEST)
Message-Id: <200408211715.i7LHFa8q024927@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: James.Bottomley@SteelEye.com
Subject: Re: 2.6.8.1-mm3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Aug 2004 12:02:24 -0400, James Bottomley wrote:
> On Sat, 2004-08-21 at 10:43, Mikael Pettersson wrote:
> > On Fri, 20 Aug 2004 03:19:19 -0700, Andrew Morton wrote:
> > >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/
> > ...
> > > bk-scsi.patch
> > 
> > This one is broken. It causes the kernel to emit a bogus
> > "program $PROG is using a deprecated SCSI ioctl, please convert it to SG_IO"
> > message whenever user-space open(2)s a SCSI block device, even
> > though user-space never did any ioctl() on it.
> 
> A simple open of /dev/sda from userland doesn't exhibit this behaviour
> for me.  What sort of device is this?  And what is the program?

It happens on my USB flash memory stick, which uses USB_STORAGE and BLK_DEV_SD.
A simple open(2) is enough to trigger the message. I'm about to try -mm3 on a
different machine which has a "true" SCSI controller/disk combo. (I should
have checked that first, sorry.)

/Mikael
