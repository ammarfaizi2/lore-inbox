Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSK0QT1>; Wed, 27 Nov 2002 11:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSK0QT1>; Wed, 27 Nov 2002 11:19:27 -0500
Received: from pool-141-153-141-211.mad.east.verizon.net ([141.153.141.211]:24818
	"EHLO bard.cbnet") by vger.kernel.org with ESMTP id <S263039AbSK0QT1>;
	Wed, 27 Nov 2002 11:19:27 -0500
Date: Wed, 27 Nov 2002 11:26:46 -0500 (EST)
From: PlasmaJohn <lkml@projectplasma.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Device firmware upload question.
Message-ID: <Pine.LNX.4.21.0211271019450.9537-100000@bard.cbnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm writing a device driver for a PCI card[1] that has no flash but requires
firmware to function.  The firmware in question is quite proprietary and is
assuredly not GPL compatible.  That said, it's not boot critical, so loading
the images via userspace would suffice.

I'd like some recommendations on the preferred method of transferring the
images to the driver from userspace.  My personal preference would be to just
use cat image.rom > $target where target is either a file in procfs (or sysfs)
or the /dev entry on an alternate minor[2].  I'd rather not do this via an
ioctl() as that would require a special loader.

Thanks,
John

PS - I'm trying to document enough of the card's interface so that somebody
else can write the real driver.  My driver is to self check my information and
to get some driver writing experience.

[1] Hauppauge's WinTV PVR250.

[2] It'll be a V4L2 device, so already the minors are going to be crowded.
    However, I don't expect (myself) to be running enough cards for it to
    become an issue.

