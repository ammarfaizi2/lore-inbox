Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRI2Wuc>; Sat, 29 Sep 2001 18:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271910AbRI2WuW>; Sat, 29 Sep 2001 18:50:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52754 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271906AbRI2WuJ>; Sat, 29 Sep 2001 18:50:09 -0400
Subject: Re: boot/root floppies in modern times?
To: clubneon@hereintown.net (Chris Meadors)
Date: Sat, 29 Sep 2001 23:55:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.33.0109291737270.1713-100000@clubneon.clubneon.com> from "Chris Meadors" at Sep 29, 2001 06:01:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15nT0e-0003HO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Obviously (but not to me initally) the USB floppy isn't a real floppy
> controlled by a floppy controller, but it is a USB mass storage device.

Correct.

> I've seen the initrd option in the kernel config along with the other RAM
> disk stuff.  I have a feeling that is the path I'm going to need to go
> down, but I've never delt with it before (I know Linus is gung-ho about
> initrd from posts I've seen by him here).  So I figure I'd better learn
> about it sooner or later.

initrd is basically a ramdisk image loaded by the bios before control
is transferred from the loader to the kernel. Thus you can have a floppy
with a file system, lilo and a kernel on it (if you squeeze).

Then you can set it up so that

The boot loads the initd
It runs the needed USB drivers
It  mounts the /dev/sda disk and copies it to /dev/ram1 ramdisk
It transfers control
