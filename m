Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319191AbSHNEGi>; Wed, 14 Aug 2002 00:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319192AbSHNEGi>; Wed, 14 Aug 2002 00:06:38 -0400
Received: from mail20.bigmailbox.com ([209.132.220.51]:2249 "EHLO
	mail20.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S319191AbSHNEGh>; Wed, 14 Aug 2002 00:06:37 -0400
Date: Tue, 13 Aug 2002 21:09:09 -0700
Message-Id: <200208140409.g7E499320183@mail20.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [128.97.184.97]
From: "Peter Plantagenet" <plantagenet@music.com>
To: linux-kernel@vger.kernel.org
Subject: [2.4.20-pre2] CPiA kernel panic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just built the new 2.4.20-pre2. 

Under Multimedia devices / Video for Linux I included:
        * CPiA Video for Linux 
        * CPiA USB lowlevel support

When booting, I got this:

V4L-Driver for Vision CPiA based cameras v0.7.4
usb.c: registered new driver cpia
Unable to handle kernel NULL pointer dereference at virtual address
00000000 printing eip:
c0119e3c
* pde=00000000
Oops: 0002
EIP: 0010: [<c0119e3c>] Not tainted
EFLAGS 00010002

After this there was additional failure information (eax, ebx, ecx, edx,
esi, edi, ebp, esp), ds: 0018 es: 0018 ss: 0018, Process swapper (pid: 1,
stackpage=C12d7000), Stack, Call trace, Code, and finally,

<o> Kernel panic: Attempted to kill init!

No error log appears to have been written; I copied this down.

I then rebuilt the kernel without the CPiA driver and the USB low-level support and the system works fine.

I had the same experience in the fall, building with 2.4.16 for an i586.
I tried to get something useful from Oops but failed.

Cheers,
Peter

bash /usr/src/linux/scripts/ver_linux
Linux 2.4.20-pre2 #2 Tue Aug 13 20:06:56 PDT 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.29
util-linux             2.11i
mount                  2.11i
modutils               2.4.8
e2fsprogs              1.27
reiserfsprogs          3.x.0k-pre9
PPP                    2.4.1
Linux C Library        x    1  1384040 Dec 18  2001 /lib/libc.so.6
Dynamic linker (ldd)   2.2.4
Linux C++ Library      2.9.
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         (none)



------------------------------------------------------------
Get YourName.Music.com- http://www.music.com/myband_main.html
Reserve your .Music.com address and reach thousands of fans!


---------------------------------------------------------------------
Express yourself with a super cool email address from BigMailBox.com.
Hundreds of choices. It's free!
http://www.bigmailbox.com
---------------------------------------------------------------------
