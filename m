Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312419AbSC3UuI>; Sat, 30 Mar 2002 15:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312397AbSC3Ut5>; Sat, 30 Mar 2002 15:49:57 -0500
Received: from 208-59-250-172.c3-0.smr-ubr1.sbo-smr.ma.cable.rcn.com ([208.59.250.172]:32896
	"EHLO bradm.net") by vger.kernel.org with ESMTP id <S312386AbSC3Utr>;
	Sat, 30 Mar 2002 15:49:47 -0500
Date: Sat, 30 Mar 2002 15:48:52 -0500
From: Bradley McLean <bradlist@bradm.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hard hang on 3Ware7850, Dual AthlonMP, Tyan2462
Message-ID: <20020330154852.A7618@nia.bradm.net>
In-Reply-To: <20020320111840.A7078@nia.bradm.net> <E16njGB-0002ku-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) [020320 11:34]:

> > Running RH7.2 with kernel.org kernels, versions 2.4.17, 2.4.18,
> > or 2.4.18 plus the IO-APIC patch posted for 2.4.19pre3.
> > Using the latest (release 7.4, driver version 19) 3ware code.
> > 
> > Tyan 2462, 3.5 GB
> > (2) AMD MP1900+
> > (6) WB1200JB
> 
> Ok thats the fourth report of this 3ware + 2462 SMP only breakage
> 
> > Anyone with suggestions, or test cases?
> 
> Apparently if you swap the Tyan for something like the ASUS dual athlon
> board it works. Dunno if its hardware, bios or software.

Well, in our case it was hardware, bios, firmware, and software.

I was able to get an ASUS, do side by side testing, and then
eventually get the Tyan working as well.

I'll post details once I complete full stress tests in various
configurations, but there *are* configurations that work correctly.

The hardware issue was a passive PCI riser card that only supports
the 3ware in one slot on the Tyan.  Works fine in the ASUS.  Sigh.

Bios is currently set to MP1.1 (will test with MP1.4 soon).

The .019 driver (with matching firmware) from 3Ware seems to be
the minimum required.

I'd like to thank 3ware's support, AngieN and AdamR specifically for
their patience, dilligence and assistance.  Wish all vendors were like
them.

-Brad
