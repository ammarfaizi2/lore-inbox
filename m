Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262864AbSJGFDD>; Mon, 7 Oct 2002 01:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262865AbSJGFDD>; Mon, 7 Oct 2002 01:03:03 -0400
Received: from air-2.osdl.org ([65.172.181.6]:33212 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262864AbSJGFDC>;
	Mon, 7 Oct 2002 01:03:02 -0400
Date: Sun, 6 Oct 2002 22:07:37 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Roberto De Leo <deleo@unica.it>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: limit to the length of args passed to kernel
In-Reply-To: <3D9EBDBD.4030402@unica.it>
Message-ID: <Pine.LNX.4.33L2.0210062156550.7363-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't seen any other replies to this on lkml, so...

On Sat, 5 Oct 2002, Roberto De Leo wrote:

| Hi,
| I recently found out the you can't pass too many args to the kernel
| through the LILO "append"
| option. Actually I passed the args through the similar "append" option
| of the SysLinux package
| (http://syslinux.zytor.com/) but on their ML I have been told it is
| equivalent to LILO's one and
| that there is a 256 characters limit for passing args at boot time to
| the kernel.

According to that mailing list, Peter Anvin has already confirmed
this.

| My question is: is this really a kernel limit or I misunderstood? if it
| is a kernel limit, is there any way to bypass it?

I didn't see any mention of what type of hardware you are using,
but COMMAND_LINE_SIZE is a #define in the Linux kernel.
You could change that, but that wouldn't "fix it."
The boot protocol interface (from LILO or SysLinux etc. to the
kernel) must also be changed for this to work.

See linux/Documentation/i386/boot.txt for that interface definition.

BTW, some other CPU architectures #define larger command line
sizes, but then they don't use this same boot interface (I
guess).

| It would be very useful for a package I am developing: it is a micro
| linux distro (the initrd.gz
| is ~4MB) containing basically only a kernel and what you need to play a
| movie through the FB.
| The kernel (2.4.19) has been compiled with support for all possible FB
| drivers, but for several
| reasons it would be nice to have two booting options: one containing the
| initialization for all
| possible FB and one turning all of them off except the vesa FB.
| Unfortunately though there are so many FB driverd that to turn them all
| off it takes much more than 256 chars!
|
| Any help would be greatly appreciated.
| Please CC me any answer to deleo@unica.it, I'm not subscrribed to the ML.

Good luck.

-- 
~Randy

