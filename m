Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265123AbSJWSX3>; Wed, 23 Oct 2002 14:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265124AbSJWSX3>; Wed, 23 Oct 2002 14:23:29 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:39144 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S265123AbSJWSX2>; Wed, 23 Oct 2002 14:23:28 -0400
Date: Wed, 23 Oct 2002 14:29:35 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Torrey Hoffman <thoffman@arnor.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Hearty AOL" for kexec
In-Reply-To: <Pine.LNX.3.95.1021023132644.14975A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0210231411050.12218-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Anything that reduces dependencies on the BIOS is good.  I'd use this
> > feature if it was available.
> 
> But 'downloading' (actually uploading) software and writing it to flash
> for a re-boot is a trivial user-mode task. The actual boot from such a
> virtual disk takes 4 seconds on a real system (AMD SC520) processor in
> an embedded system. You don't need any special kernel hooks.

The flashing can be trivial, but downloading and verification of the
software is not.  One of the systems I was working on required synchronous
PPP protocol and HDLC drivers to load the kernel.  The network was
untrusted, so checking the signature of the kernel was a very good idea.  
None of that functionality was required for normal operation.  In fact, it
was preferred to disable any network protocols on the working nodes.

By the way, kexec makes it possible to avoid any write operations.  The
bootstrap kernel can be in the true ROM (not PROM), the secondary kernel
can be loaded into the RAM.

Finally, I'm subscribed to the GNU GRUB mailing list, and it's quite
common to see people trying to boot their systems over 802.11 or something
like that, not to mention problems with large hard drives and USB
keyboards.  kexec makes it possible to implement a bootloader with full
BIOS-independent support for USB keyboards and drives, IDE, SCSI and
everything else, even fancy animated logos on the framebuffer.

-- 
Regards,
Pavel Roskin

