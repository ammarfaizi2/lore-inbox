Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbTIOXDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbTIOXDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:03:00 -0400
Received: from dsl093-244-091.ric1.dsl.speakeasy.net ([66.93.244.91]:56568
	"EHLO perl.xsdg.org") by vger.kernel.org with ESMTP id S261689AbTIOXCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:02:52 -0400
Date: Mon, 15 Sep 2003 23:02:43 +0000
From: xsdg <xsdg@freenode.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1, -test4 control key "stuck"
Message-Id: <20030915230243.12d8586f.xsdg@freenode.org>
In-Reply-To: <20030915232800.A1166@pclin040.win.tue.nl>
References: <20030915000411.6d35386d.xsdg@freenode.org>
	<20030915110028.B957@pclin040.win.tue.nl>
	<20030915205546.GA12833@perl>
	<20030915232800.A1166@pclin040.win.tue.nl>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.'4gP.?dwcaZv?O"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.'4gP.?dwcaZv?O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2003 23:28:00 +0200
Andries Brouwer <aebr@win.tue.nl> wrote:

> On Mon, Sep 15, 2003 at 08:55:46PM +0000, xsdg wrote:
> 
::snip? SNIP!::
> > any idea what might cause the key sticking problem?
> 
> If a key release is not seen, 2.4 doesnt mind, but 2.6 keeps repeating.

I ran into the problem again under 2.6.0-test4-mm6 less than 45 minutes after
rebooting. I modprobed evdev.ko and have included the output (run through
hexdump -C) as [1].  I am keeping the original, unprocessed file incase you need
it.  To obtain the output, I pressed and immediately released the following keys
in the following order:
"q", "w", "e", "r", "t", "y", "u", "i", "o", "p", <l-shift>, <l-ctrl>, <l-alt>,
<space>, <r-alt>, <r-shift>, <enter>

I then removed evdev.ko, modprobed evbug.ko, and repeated the key sequence shown
above.  These resulted in [2] popping up in /var/log/kern.log

On my laptop keyboard, there is no right-control key.  The letters I pressed run
across the top of my keyboard from left to right (below the numbers).  To
prevent any confusion, the problem persisted after pressing all of these keys.


> 
> > Also, I'm not sure how the final issue I described
> 
> Do not recall all items of all letters I answer - sorry.
Sorry; this is a C+P of what I said in my original mail:
 	Most recently, this problem manifested itself by (as far as I can tell)
switching the keyboard keymap (this, occurred while I was in X, with Mozilla on
the current workspace).  After switching to vt2, I am now unable to return to X
(vt 7).  Pressing the numeral keys acts as if shift were held down while using
an odd alternate keymap (2 -> "^U", 4->"$", [7-0] -> ["{", "[", "]", "}", "\"],
e -> Euro symbol).  You can find the physical layout of my keyboard at [2]. 
While pressing the shift key, no characters are displayed on the console. 
Pressing <alt>+Fn or <ctrl>+<alt>+Fn to switch to another VT does not do
anything; the same occurs when trying <alt>+left/right

> 
> Andries
> 

[1]
00000000  ba 3e 66 3f 71 51 0e 00  01 00 10 00 01 00 00 00  |.>f?qQ..........|
00000010  ba 3e 66 3f 73 51 0e 00  00 00 00 00 00 00 00 00  |.>f?sQ..........|
00000020  bb 3e 66 3f 7e 56 00 00  01 00 10 00 00 00 00 00  |.>f?~V..........|
00000030  bb 3e 66 3f 80 56 00 00  00 00 00 00 00 00 00 00  |.>f?.V..........|
00000040  bc 3e 66 3f f4 24 0f 00  01 00 11 00 01 00 00 00  |.>f?.$..........|
00000050  bc 3e 66 3f f6 24 0f 00  00 00 00 00 00 00 00 00  |.>f?.$..........|
00000060  bd 3e 66 3f 87 78 01 00  01 00 11 00 00 00 00 00  |.>f?.x..........|
00000070  bd 3e 66 3f 89 78 01 00  00 00 00 00 00 00 00 00  |.>f?.x..........|
00000080  bd 3e 66 3f 9a 6e 0a 00  01 00 12 00 01 00 00 00  |.>f?.n..........|
00000090  bd 3e 66 3f 9c 6e 0a 00  00 00 00 00 00 00 00 00  |.>f?.n..........|
000000a0  bd 3e 66 3f 6a 0a 0c 00  01 00 12 00 00 00 00 00  |.>f?j...........|
000000b0  bd 3e 66 3f 6c 0a 0c 00  00 00 00 00 00 00 00 00  |.>f?l...........|
000000c0  be 3e 66 3f 39 5b 0e 00  01 00 13 00 01 00 00 00  |.>f?9[..........|
000000d0  be 3e 66 3f 3b 5b 0e 00  00 00 00 00 00 00 00 00  |.>f?;[..........|
000000e0  bf 3e 66 3f d3 a8 00 00  01 00 13 00 00 00 00 00  |.>f?............|
000000f0  bf 3e 66 3f d5 a8 00 00  00 00 00 00 00 00 00 00  |.>f?............|
00000100  bf 3e 66 3f ed e0 0d 00  01 00 14 00 01 00 00 00  |.>f?............|
00000110  bf 3e 66 3f ef e0 0d 00  00 00 00 00 00 00 00 00  |.>f?............|
00000120  c0 3e 66 3f d0 33 00 00  01 00 14 00 00 00 00 00  |.>f?.3..........|
00000130  c0 3e 66 3f d2 33 00 00  00 00 00 00 00 00 00 00  |.>f?.3..........|
00000140  c1 3e 66 3f 81 48 08 00  01 00 15 00 01 00 00 00  |.>f?.H..........|
00000150  c1 3e 66 3f 84 48 08 00  00 00 00 00 00 00 00 00  |.>f?.H..........|
00000160  c1 3e 66 3f 16 45 09 00  01 00 15 00 00 00 00 00  |.>f?.E..........|
00000170  c1 3e 66 3f 17 45 09 00  00 00 00 00 00 00 00 00  |.>f?.E..........|
00000180  c2 3e 66 3f 30 28 0f 00  01 00 16 00 01 00 00 00  |.>f?0(..........|
00000190  c2 3e 66 3f 32 28 0f 00  00 00 00 00 00 00 00 00  |.>f?2(..........|
000001a0  c3 3e 66 3f 24 2f 01 00  01 00 16 00 00 00 00 00  |.>f?$/..........|
000001b0  c3 3e 66 3f 26 2f 01 00  00 00 00 00 00 00 00 00  |.>f?&/..........|
000001c0  c3 3e 66 3f a5 27 0f 00  01 00 17 00 01 00 00 00  |.>f?.'..........|
000001d0  c3 3e 66 3f a7 27 0f 00  00 00 00 00 00 00 00 00  |.>f?.'..........|
000001e0  c4 3e 66 3f 3d 36 01 00  01 00 17 00 00 00 00 00  |.>f?=6..........|
000001f0  c4 3e 66 3f 3f 36 01 00  00 00 00 00 00 00 00 00  |.>f??6..........|
00000200  c4 3e 66 3f 47 0b 0f 00  01 00 18 00 01 00 00 00  |.>f?G...........|
00000210  c4 3e 66 3f 49 0b 0f 00  00 00 00 00 00 00 00 00  |.>f?I...........|
00000220  c5 3e 66 3f 24 c2 00 00  01 00 18 00 00 00 00 00  |.>f?$...........|
00000230  c5 3e 66 3f 26 c2 00 00  00 00 00 00 00 00 00 00  |.>f?&...........|
00000240  c6 3e 66 3f a4 8b 00 00  01 00 19 00 01 00 00 00  |.>f?............|
00000250  c6 3e 66 3f a6 8b 00 00  00 00 00 00 00 00 00 00  |.>f?............|
00000260  c6 3e 66 3f e2 d4 01 00  01 00 19 00 00 00 00 00  |.>f?............|
00000270  c6 3e 66 3f e4 d4 01 00  00 00 00 00 00 00 00 00  |.>f?............|
00000280  dc 3e 66 3f b3 2c 0a 00  01 00 2a 00 01 00 00 00  |.>f?.,....*.....|
00000290  dc 3e 66 3f b5 2c 0a 00  00 00 00 00 00 00 00 00  |.>f?.,..........|
000002a0  dc 3e 66 3f ca 80 0b 00  01 00 2a 00 00 00 00 00  |.>f?......*.....|
000002b0  dc 3e 66 3f cc 80 0b 00  00 00 00 00 00 00 00 00  |.>f?............|
000002c0  de 3e 66 3f 6d c2 0e 00  01 00 1d 00 01 00 00 00  |.>f?m...........|
000002d0  de 3e 66 3f 6f c2 0e 00  00 00 00 00 00 00 00 00  |.>f?o...........|
000002e0  df 3e 66 3f 30 cf 00 00  01 00 1d 00 00 00 00 00  |.>f?0...........|
000002f0  df 3e 66 3f 32 cf 00 00  00 00 00 00 00 00 00 00  |.>f?2...........|
00000300  e5 3e 66 3f d9 ac 04 00  01 00 38 00 01 00 00 00  |.>f?......8.....|
00000310  e5 3e 66 3f db ac 04 00  00 00 00 00 00 00 00 00  |.>f?............|
00000320  e5 3e 66 3f 22 fe 05 00  01 00 38 00 00 00 00 00  |.>f?".....8.....|
00000330  e5 3e 66 3f 24 fe 05 00  00 00 00 00 00 00 00 00  |.>f?$...........|
00000340  e8 3e 66 3f b4 b2 00 00  01 00 39 00 01 00 00 00  |.>f?......9.....|
00000350  e8 3e 66 3f b6 b2 00 00  00 00 00 00 00 00 00 00  |.>f?............|
00000360  e8 3e 66 3f 7f f6 01 00  01 00 39 00 00 00 00 00  |.>f?......9.....|
00000370  e8 3e 66 3f 81 f6 01 00  00 00 00 00 00 00 00 00  |.>f?............|
00000380  f5 3e 66 3f e2 6a 03 00  01 00 64 00 01 00 00 00  |.>f?.j....d.....|
00000390  f5 3e 66 3f e5 6a 03 00  00 00 00 00 00 00 00 00  |.>f?.j..........|
000003a0  f5 3e 66 3f 35 01 05 00  01 00 64 00 00 00 00 00  |.>f?5.....d.....|
000003b0  f5 3e 66 3f 37 01 05 00  00 00 00 00 00 00 00 00  |.>f?7...........|
000003c0  fb 3e 66 3f a7 c1 0e 00  01 00 36 00 01 00 00 00  |.>f?......6.....|
000003d0  fb 3e 66 3f a9 c1 0e 00  00 00 00 00 00 00 00 00  |.>f?............|
000003e0  fc 3e 66 3f 95 d0 00 00  01 00 36 00 00 00 00 00  |.>f?......6.....|
000003f0  fc 3e 66 3f 97 d0 00 00  00 00 00 00 00 00 00 00  |.>f?............|
00000400  fd 3e 66 3f 68 d7 08 00  01 00 1c 00 01 00 00 00  |.>f?h...........|
00000410  fd 3e 66 3f 6a d7 08 00  00 00 00 00 00 00 00 00  |.>f?j...........|
00000420  fd 3e 66 3f f8 27 0a 00  01 00 1c 00 00 00 00 00  |.>f?.'..........|
00000430  fd 3e 66 3f fa 27 0a 00  00 00 00 00 00 00 00 00  |.>f?.'..........|
00000440

[2]
Sep 15 22:46:12 cpp kernel: evbug.c: Connected device: "PS/2 Generic Mouse", isa0060/serio1/input0
Sep 15 22:46:12 cpp kernel: evbug.c: Connected device: "AT Set 2 keyboard", isa0060/serio0/input0
Sep 15 22:46:12 cpp kernel: evbug.c: Connected device: "Gyration GyroPoint RF Technology Receiver", usb-0000:00:1d.0-2/input0
Sep 15 22:46:12 cpp kernel: evbug.c: Connected device: "Gyration GyroPoint RF Technology Receiver", usb-0000:00:1d.0-2/input1
Sep 15 22:49:17 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 16, Value: 1
Sep 15 22:49:17 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:17 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 16, Value: 0
Sep 15 22:49:17 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:24 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 17, Value: 1
Sep 15 22:49:24 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:24 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 17, Value: 0
Sep 15 22:49:24 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:25 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 18, Value: 1
Sep 15 22:49:25 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:25 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 18, Value: 0
Sep 15 22:49:25 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:27 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 19, Value: 1
Sep 15 22:49:27 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:27 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 19, Value: 0
Sep 15 22:49:27 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:29 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 20, Value: 1
Sep 15 22:49:29 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:29 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 20, Value: 0
Sep 15 22:49:29 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:31 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 21, Value: 1
Sep 15 22:49:31 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:31 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 21, Value: 0
Sep 15 22:49:31 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:35 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 22, Value: 1
Sep 15 22:49:35 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:35 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 22, Value: 0
Sep 15 22:49:35 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:38 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 23, Value: 1
Sep 15 22:49:38 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:38 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 23, Value: 0
Sep 15 22:49:38 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:39 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 24, Value: 1
Sep 15 22:49:39 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:39 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 24, Value: 0
Sep 15 22:49:39 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:42 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 25, Value: 1
Sep 15 22:49:42 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:42 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 25, Value: 0
Sep 15 22:49:42 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:45 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 42, Value: 1
Sep 15 22:49:45 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:45 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 42, Value: 0
Sep 15 22:49:45 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:47 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 29, Value: 1
Sep 15 22:49:47 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:47 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 29, Value: 0
Sep 15 22:49:47 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:50 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 56, Value: 1
Sep 15 22:49:50 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:50 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 56, Value: 0
Sep 15 22:49:50 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:51 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 57, Value: 1
Sep 15 22:49:51 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:51 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 57, Value: 0
Sep 15 22:49:51 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:55 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 100, Value: 1
Sep 15 22:49:55 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:55 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 100, Value: 0
Sep 15 22:49:55 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:57 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 54, Value: 1
Sep 15 22:49:57 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:57 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 54, Value: 0
Sep 15 22:49:57 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:59 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 28, Value: 1
Sep 15 22:49:59 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0
Sep 15 22:49:59 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 28, Value: 0
Sep 15 22:49:59 cpp kernel: evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0


-- 
| Why do people with closed minds always open their |
|   mouths?                                         |
) http://www.cuodan.net/~xsdg/    xsdg@freenode.org (


--=.'4gP.?dwcaZv?O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/ZkUYLa8oArNOsUERAjvgAJ0UPqmaa1U64jykp3KqgS/veLDMMACgko3X
k0XSRUzIXymO6DfFB2nheDU=
=eaq0
-----END PGP SIGNATURE-----

--=.'4gP.?dwcaZv?O--
