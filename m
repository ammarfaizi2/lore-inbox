Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310360AbSCBMX7>; Sat, 2 Mar 2002 07:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310363AbSCBMXt>; Sat, 2 Mar 2002 07:23:49 -0500
Received: from pc-62-30-142-167-nm.blueyonder.co.uk ([62.30.142.167]:5896 "EHLO
	merry.bs.lan") by vger.kernel.org with ESMTP id <S310360AbSCBMXl>;
	Sat, 2 Mar 2002 07:23:41 -0500
Date: Sat, 2 Mar 2002 12:23:39 +0000
To: Ulrich Hahn <ulrich.hahn@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA-related IDE problems on GA-7ZX motherboard
Message-ID: <20020302122339.A31436@merry.bs.lan>
Mail-Followup-To: Ulrich Hahn <ulrich.hahn@web.de>,
	Charles Briscoe-Smith <charles@briscoe-smith.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C807EB5.24BAABC6@web.de>
User-Agent: Mutt/1.3.18i
X-PGP-Fingerprint: 1024R/B35EE811  74 68 AB 2E 1C 60 22 94  B8 21 2D 01 DE 66 13 E2
From: Charles Briscoe-Smith <charles@briscoe-smith.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2002 at 08:26:45AM +0100, Ulrich Hahn wrote:
> Help!
> 
> You wrote in a linux mailing list about one year ago, describing mainly
> the same probelm I have when loading pcmcia-modules into a 2.4.14
> kernel: The ide0 reports "lost interrupt" and rien ne va plus.
> 
> >I'm having problems related to using a pcmcia bridge on a desktop PC.
> >The machine used to contain a TMC TI5-VG+ motherboard with a 400Mhz K6-II.
> >With the TMC motherboard, everything worked worked fine.  When I upgraded
> >the machine to a Gigabyte GA-7ZX with 800Mhz Athlon, the CD-writer and
> >LS-120 floppy on the secondary IDE channel stopped working.  By fiddling
> >around with the kernel configuration, I've finally narrowed it down to
> >the PC card drivers; the machine contains a Chase-AT "Duo" ISA-to-PCMCIA
> >bridge.
> 
> I read lost of questions like this - but mainly NO answer to it at all.
> Does it happen only to few people? Is it not relevant?
> 
> Personal question: did you find a solution?

Yes, I did, and it has since been documented in the PCMCIA HOWTO,
section 2.3, subsection "Card readers for desktop systems":

  For Chase CardPORT and Altec ISA card readers using the Cirrus PD6722
  ISA-to-PCMCIA bridge, the i82365 driver should be loaded with a
  ``has_ring=0'' parameter to prevent irq 15 conflicts.

I had been trying the option "has_ring=1", which I didn't know was
the default.

[ CC'ed linux-kernel so that this gets into its archives.  I am not on
linux-kernel so, if replying, please CC me (and, I presume, Ulrich). ]

-- 
Charles Briscoe-Smith             Hacking Free Software for fun and profit
Governing Law:
   This License Agreement shall be construed and governed in accordance
   with the laws of the State of Inebriation. 
                                    -- http://www.thalia.org/computer.html
