Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSKTUEk>; Wed, 20 Nov 2002 15:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSKTUEk>; Wed, 20 Nov 2002 15:04:40 -0500
Received: from trillium-hollow.org ([209.180.166.89]:29369 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S262224AbSKTUEh>; Wed, 20 Nov 2002 15:04:37 -0500
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] Athlon testers needed. 
In-Reply-To: Your message of "Wed, 20 Nov 2002 18:53:11 GMT."
             <20021120185311.GB10698@suse.de> 
Date: Wed, 20 Nov 2002 12:11:35 -0800
From: erich@uruk.org
Message-Id: <E18EbCB-0003Z9-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave Jones <davej@codemonkey.org.uk> wrote:

> In some obscure documentation, I found out that recent Athlons
> (model 8 stepping 1 and greater) behave better with certain MSRs
> programmed slightly differently to those of earlier models.
> It's likely a lot of BIOSen out there don't get this right
> (Especially in the BIOS older than CPU case).
> 
> x86info[1] will be able to dump these registers (run as root
> and use -m option), and mail me the results so I can confirm
> my suspicions.  I've a patch pending, but I'd rather get some
> test data before unleashing it on unsuspecting victims.
> 
> I'm particularly interested in hearing from folks who have
> been experiencing problems with model 8 and above Athlons,
> earlier models are less interesting for the moment.
> 
> 		Dave
> 
> [1] http://www.codemonkey.org.uk/x86info/x86info-1.11.tar.gz


2 points:

  --  The link is:

	http://www.codemonkey.org.uk/x86info/x86info-1.11.tgz

  --  A note to those not in the know to load the "msr" driver
      first, for example on my RedHat system:

	insmod msr


In any case, here's the result from my recently acquired Athlon
XP 2600+:


			31       23       15       7 
MSR: 0x0000002a=0x00000000 : 00000000 00000000 00000000 00000000
MSR: 0xc0000080=0x00000000 : 00000000 00000000 00000000 00000000
MSR: 0xc0010010=0x00160604 : 00000000 00010110 00000110 00000100
MSR: 0xc0010015=0x080b9008 : 00001000 00001011 10010000 00001000
MSR: 0xc001001b=0x6003d22f : 01100000 00000011 11010010 00101111

Family: 6 Model: 8 Stepping: 1
CPU Model : Athlon XP (Thoroughbred)[B0]
Processor name string: AMD Athlon(tm) XP Processor

PowerNOW! Technology information
Available features:
	  Temperature sensing diode present.


For comparison, here is the output from an Athlon XP 1800+:

			31       23       15       7 
MSR: 0x0000002a=0x00000000 : 00000000 00000000 00000000 00000000
MSR: 0xc0000080=0x00000000 : 00000000 00000000 00000000 00000000
MSR: 0xc0010010=0x00168604 : 00000000 00010110 10000110 00000100
MSR: 0xc0010015=0x01001008 : 00000001 00000000 00010000 00001000
MSR: 0xc001001b=0x6003d22f : 01100000 00000011 11010010 00101111

Family: 6 Model: 6 Stepping: 2
CPU Model : Athlon MP (palomino)
Processor name string: AMD Athlon(TM) MP 1800+

PowerNOW! Technology information
Available features:
	  Temperature sensing diode present.


--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
