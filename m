Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280695AbRKGAfg>; Tue, 6 Nov 2001 19:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280725AbRKGAeY>; Tue, 6 Nov 2001 19:34:24 -0500
Received: from mail2.cableone.net ([24.116.0.54]:42768 "EHLO
	mail2.cableone.net") by vger.kernel.org with ESMTP
	id <S280722AbRKGAeL>; Tue, 6 Nov 2001 19:34:11 -0500
Date: Tue, 6 Nov 2001 18:34:09 -0600
From: James Funkhouser <news@funkhouser.org>
To: linux-kernel@vger.kernel.org
Cc: news@funkhouser.org
Subject: Re: Seg fault when syncing Sony Clie 760 with USB cradle
Message-ID: <20011106183409.A16895@cableone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter A. Goodall" <pete@ximian.com> wrote:

> syncing with Coldsync no longer causes a kernel panic.  It just doesn't
> work.  It can't communicate with the Clie to get the serial number and
> other information.  Since I'm using devfs I can't say it is the kernel. 

 I have recently been trying to get my Sony Clie' 760 to work with
Linux, also.  I am using coldsync 2.2.2 and kernel 2.4.13-ac3 (it
didn't work with 2.4.12, either).  I am not using devfs.  When I
attempt to sync, I get a segfault from coldsync and the following
messages from the kernel:

--- BEGIN dmesg output ---
hub.c: USB new device connect on bus1/2, assigned device number 5
usb.c: kmalloc IF d14598c0, numif 1
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 5 default language ID 0x409
Manufacturer: Sony Corp.
Product: Palm Handheld
usbserial.c: Sony Clie 4.0 converter detected
visor.c: Sony Clie 4.0: Number of ports: 2
visor.c: Sony Clie 4.0: port 1, is for Generic use and is bound to ttyUSB0
visor.c: Sony Clie 4.0: port 2, is for HotSync use and is bound to ttyUSB1
usb-uhci.c: interrupt, status 2, frame# 452
usb_control/bulk_msg: timeout
visor.c: visor_startup - error getting first unknown palm command
usb_control/bulk_msg: timeout
visor.c: visor_startup - error getting second unknown palm command
usbserial.c: Sony Clie 4.0 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usbserial.c: Sony Clie 4.0 converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
usb.c: serial driver claimed interface d14598c0
usb.c: kusbd: /sbin/hotplug add 5
usb.c: kusbd policy returned 0xfffffffe
Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
e084a110
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<e084a110>]    Not tainted
EFLAGS: 00010202
eax: de51de00   ebx: dbbd5894   ecx: dbbd58f0   edx: 00000000
esi: dbbd5800   edi: 00000000   ebp: dbbd58f0   esp: d12fbeb0
ds: 0018   es: 0018   ss: 0018
Process coldsync (pid: 16918, stackpage=d12fb000)
Stack: de8d8000 da72e720 dd59a900 c18862a0 e0844284 dbbd5894 da72e720 00000000 
       00000000 c0155b2b de8d8000 da72e720 00000000 da72e720 dd59a900 c18862a0 
       dfff7420 0002bf28 de8d8000 ded6ba40 00000000 c013507b dfff7420 00000000 
Call Trace: [<e0844284>] [<c0155b2b>] [<c013507b>] [<c01347e7>] [<c012ca02>] 
   [<c012bb1d>] [<c012ba5a>] [<c012bd4a>] [<c0106d07>] 

Code: 89 42 14 8b 4e 04 0f b6 43 24 c1 e0 0f 8b 11 c1 e2 08 09 c2 
 <7>hub.c: port 2 connection change
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
usb.c: USB disconnect on device 5
--- END dmesg output ---

 Everything still works fine with my USB Visor.  One of the things
that caught my eye is "Sony Clie 4.0 converter".  Unlike the 710,
the 760 runs PalmOS 4.1, rather than 4.0.  Perhaps this has
something to do with it??

 Please CC me on replies.

James
