Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265757AbSLCApU>; Mon, 2 Dec 2002 19:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265732AbSLCApU>; Mon, 2 Dec 2002 19:45:20 -0500
Received: from quark.amimatica.com ([213.139.24.154]:51344 "EHLO
	quark.amimatica.com") by vger.kernel.org with ESMTP
	id <S265380AbSLCApT> convert rfc822-to-8bit; Mon, 2 Dec 2002 19:45:19 -0500
Message-Id: <5.1.1.6.0.20021203004621.00b5a770@mail.adv-solutions.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Tue, 03 Dec 2002 01:52:09 +0100
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?Jos=E9?= Luis =?iso-8859-1?Q?Tall=F3n?= 
	<jltallon@adv-solutions.net>
Subject: Linux-2.4.20: bug with radeonfb
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Environment:	gcc-2.95.4, latest dev tools from Debian "Sarge"( testing )
Kernel:	2.4.20 + patch-2.4.20-ac1 from ftp.kernel.org
Machine:	i386 (intel P4-M/1700 ) / 512MB DDR266, chipset i845MP
Graphics subsystem:	ATI Radeon M7, 64MB DDR
			Samsung LTN-1050 flatpanel, 1400x1050 physical resolution (DVI connection)


First of all, i must congratulate all kernel developers for this wonderful 
work-of-art which Linux is and will continue to be :) Thanks for making 
this world a little better!

On to the point:

"Go's":	
	i845MP chipset supported ( didn't previously work ). ICH3 & co. detected 
and used. Some minor details left, though :)
	UDMA100 enabled and working

"No Go's":
	Radeon M7 AGP:
	- Framebuffer:	unreadable output ( did work _perfectly_ with Linux-2.4.19 ).
	Looks like there's a bug somewhere in the rendering code( kernel 
autodetects and configures a 175x65 framebuffer, as previously):
output seems to be "misplaced" -- might be a little assumption when 
calculating line offsets.
Text lines, although bent to the right( 60º angle or so ), look _extremely 
long_ (might be a wrong appreciation)
"Tux" logo is unrecogniceable too :(

	- DRM 4.1( v20020828 ) works nicely with XFree 4.2.1
	- Xvid extension works

dmesg gives this ( double-checked with 2.4.19 ): relevant sections are 
identical to 2.4.19
---
Pentium 4 Mobility - stepping 04
[...]
ref_clk=2700, ref_div=12, xclk=16600 from BIOS
Samsung LTN-1050P1-L02 flatpanel
DFP 1400x1050 from BIOS
Radeon M7 LW DDR SGRAM 64MB
colour framebuffer 175x65
---

Feel free to ask for whatever config detail i might have forgotten to add.
I'm not sure if i will have time enough to contribute (part of) a patch -- 
gotta leave some time for lunch and sleep ;) Wouldn't mind to help, however.


Please CC any relevant messages to me. Sorry for not subscribing, but i 
already receive 300+ e-mails daily :-|

TIA
Regards,
	J.L.

--
All my other computers run Linux.
This is an split-personality machine ;) 

