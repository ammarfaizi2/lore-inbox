Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWCMRBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWCMRBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 12:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWCMRBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 12:01:19 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:47522 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751618AbWCMRBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 12:01:19 -0500
Date: Mon, 13 Mar 2006 11:55:46 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] Require VM86 with VESA framebuffer
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Antonino Daplas <adaplas@pol.net>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <200603131159_MC3-1-BA89-78CA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1142261096.25773.19.camel@localhost.localdomain>
References: <1142261096.25773.19.camel@localhost.localdomain>

On Mon, 13 Mar 2006 14:44:56 +0000, Alan Cox wrote:


> VESA does not require VM86 so this change is completely wrong.

What is this all about then?

Begin quote ------------------------------------------------------------------

 Date: 10 Mar 2006 11:23:18 GMT
 From: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
 Subject: [2.6.16-rc5-git13] Xorg.log difference
 To: linux-kernel@vger.kernel.org
 Message-ID: <5038a3.6a2ae9@familynet-international.net>

i see this difference with 2.6.16-rc5-git13 kernel.  more info on request -kp

5c5
< Current Operating System: Linux fret 2.6.16-rc5-git13 #2 Fri Mar 10 10:45:41
2006 i686
---
> Current Operating System: Linux fret 2.6.15.6 #1 Tue Mar 07 13:44:04 2006 i686
13c13
< (==) Log file: "/var/log/Xorg.0.log", Time: Fri Mar 10 04:49:26 2006
---
> (==) Log file: "/var/log/Xorg.0.log", Time: Fri Mar 10 05:02:35 2006
327,337c327,383
< (EE) ATI(0): unknown type(0xffffffff)=0xff
< (II) ATI(0): EAX=0x00004f00, EBX=0x00000000, ECX=0x00000000, EDX=0x00000000
< (II) ATI(0): ESP=0x00000ffa, EBP=0x00000000, ESI=0x00000000, EDI=0x00002000
< (II) ATI(0): CS=0xc000, SS=0x0100, DS=0x0040, ES=0x0000, FS=0x0000, GS=0x0000
< (II) ATI(0): EIP=0x00001306, EFLAGS=0x00003200
< (II) ATI(0): code at 0x000c1306:
<  fb fc 80 fc a0 0f 84 a6 3c 80 fc 4f 0f 84 c0 2d
<  1e 06 57 56 55 52 51 53 50 50 8a c4 32 e4 d1 e0
< (II) stack at 0x00001ffa:
<  00 06 00 00 00 32
< (II) ATI(0): VESA BIOS not detected
---
> (II) ATI(0): VESA BIOS detected
> (II) ATI(0): VESA VBE Version 2.0
> (II) ATI(0): VESA VBE Total Mem: 4096 kB
> (II) ATI(0): VESA VBE OEM: ATI MACH64
> (II) ATI(0): VESA VBE OEM Software Rev: 1.0
> (II) ATI(0): VESA VBE OEM Vendor: ATI Technologies Inc.
> (II) ATI(0): VESA VBE OEM Product: MACH64GT
> (II) ATI(0): VESA VBE OEM Product Rev: 01.00

End quote ------------------------------------------------------------------
Begin quote ------------------------------------------------------------------

 Date: 11 Mar 2006 03:01:00 GMT
 From: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
 Subject: Re: [2.6.16-rc5-git13] Xorg.log difference
 To: linux-kernel@vger.kernel.org
 Message-ID: <e038ac.6aa820@familynet-international.net>

-=> In article 10 Mar 06  17:20:10, Ingo Oeser wrote to All <=-

yo Ingo :)

[ mach64 rage 3d dual pci+agp1 vbe undetected  x11-6.7.0-i586-4 ]
[..]
 IO> Did you disable vm86 support, too?

 IO> # CONFIG_VM86 is not set
bet that's it - thank ya        :)

End quote ------------------------------------------------------------------


> Worse
> still the x86-64 does not support VM86 so you have just crippled the
> x86-64 port unneccessarily.

 Huh?  I checked my working x86_64 .config and found this:

        CONFIG_X86_64=y
        CONFIG_64BIT=y
        CONFIG_X86=y
        ...
        CONFIG_VM86=y

so I assumed it was OK to force VM86.




-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"
