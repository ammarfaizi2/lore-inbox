Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbRHPWph>; Thu, 16 Aug 2001 18:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbRHPWp1>; Thu, 16 Aug 2001 18:45:27 -0400
Received: from doc.ece.uci.edu ([128.195.174.34]:3759 "EHLO doc.ece.uci.edu")
	by vger.kernel.org with ESMTP id <S268940AbRHPWpL>;
	Thu, 16 Aug 2001 18:45:11 -0400
From: Ossama Othman <ossama@doc.ece.uci.edu>
Date: Thu, 16 Aug 2001 15:45:25 -0700
To: linux-kernel@vger.kernel.org
Cc: ossama@uci.edu
Subject: Re: Dual 1.7 GHz Xeon -- slow, interrupts not balance, etc
Message-ID: <20010816154525.A11206@ece.uci.edu>
In-Reply-To: <20010816145446.B7801@ece.uci.edu> <E15XVLG-0006AI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15XVLG-0006AI-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 16, 2001 at 11:10:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Thanks for the response!

On Thu, Aug 16, 2001 at 11:10:18PM +0100, Alan Cox wrote:
> If you look at the figures from the various benchmarking sites that doesnt
> sound unexpected. If you can recode your applications (eg if its a complex
> analysis problem) to use SSE2 and the like you may well get big speed ups

I noticed those web sites, too, which is why I'm confused as to why
I'm achieving such dismal performance.

I don't think we can take advantage of the SSE2 instruction since
we're mostly using these boxes as fast build/compile boxes.

One of the benchmark sites that I browsed through showed a 30 second
difference in kernel 2.4.2 compile times between a 1 GHz PIII a 1.7GHz
Xeon.  I realize that such differences are application dependent, but
we only noticed a 10 second difference in our application (ACE/TAO).
Sometimes the PIII box was faster with the compiles, too.

I wasn't expecting a 70% increase in speed but I did expect a
noticeable performance boost rather than a equal or lesser
performance.  Was I expecting too much?

> > Any ideas why CPU1 isn't getting any interrupts?  Incidentally,
> > interrupts appear to be fairly well balanced on our PIII box.
> 
> Do the boot messages ay anothing about this ?

To be honest, I'm not sure what I should be looking for (sorry... I'm
not a kernel hacker yet).  Should I just send the boot messages (about
a 15K file)?

I do get the following from 2.4.7 boot (2.4.8 has the same messages):

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : IO APIC version: 0020
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    91
 0f 003 03  0    0    0   0   0    1    1    99
 10 003 03  1    1    0   1   0    1    1    A1
 11 003 03  1    1    0   1   0    1    1    A9
 12 003 03  1    1    0   1   0    1    1    B1
 13 003 03  1    1    0   1   0    1    1    B9
 14 003 03  1    1    0   1   0    1    1    C1
 15 003 03  1    1    0   1   0    1    1    C9
 16 003 03  1    1    0   1   0    1    1    D1
 17 003 03  1    1    0   1   0    1    1    D9

I'll send this stuff off to linux-smp, as stated by the message.  I
also get the following (probably unrelated) messages:

PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent

agpgart: Unsupported Intel chipset (device id: 2531), you might want
to try agp_try_unsupported=1.
agpgart: no supported devices found.


BTW, if this mailing list isn't the appropriate forum for these
issues, I'd be glad to move it to another forum.  I certainly don't
want to both the community with noise.

Thanks again,
-Ossama
-- 
Ossama Othman <ossama@ece.uci.edu>
Distributed Object Computing Laboratory, Univ. of California at Irvine
1024D/F7A394A8 - 84ED AA0B 1203 99E4 1068  70E6 5EB7 5E71 F7A3 94A8
