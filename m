Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129354AbRCBRn3>; Fri, 2 Mar 2001 12:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129355AbRCBRnU>; Fri, 2 Mar 2001 12:43:20 -0500
Received: from palrel3.hp.com ([156.153.255.226]:33798 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S129354AbRCBRnL>;
	Fri, 2 Mar 2001 12:43:11 -0500
Message-Id: <200103021746.JAA29510@milano.cup.hp.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: The IO problem on multiple PCI busses 
In-Reply-To: Your message of "Thu, 01 Mar 2001 18:19:37 PST."
             <15007.825.483003.106274@pizda.ninka.net> 
Date: Fri, 02 Mar 2001 09:46:12 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> There is another case you are ignoring.  Some devices support memory
> space as well as I/O space, but only operate reliably when their
> I/O space window is used to access it.

ok. Those also fall into the category of "I personally don't care" :^)

> It just sounds to me like the hppa pci controllers are crap,
> especially the GSC one.

In defense of the HW designers, Dino operates extremely well
in the environment it was designed for. Principally, workstations
with HP graphics cards (which only use MMIO). Optimizations for
graphics make it one of the fastest PCI-1X (and Cujo is PCI-2X)
HBA's - that's according to a 3rd party graphics card vendor who
has ported to the major high-end platforms.

> At least the rope one does something
> reasonable when you have a 64-bit kernel.  The horrors you've told me
> about the IOMMUs and stream-caches on these chips further confirms my
> theory :-)

Yup. *sigh*.  Between chip bugs, tradeoffs of performance, time to market,
and simple programming interface, things got pretty ugly (its the
old saying about "Pick any two").

grant

Grant Grundler
parisc-linux {PCI|IOMMU|SMP} hacker
+1.408.447.7253
