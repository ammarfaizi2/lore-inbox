Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264776AbTFEQ1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbTFEQ1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:27:43 -0400
Received: from ppp-62-245-208-76.mnet-online.de ([62.245.208.76]:1942 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S264776AbTFEQ1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:27:40 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: /proc/bus/pci
From: Julien Oster <lkml@mf.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Thu, 05 Jun 2003 18:41:10 +0200
In-Reply-To: <20030605160017$10e1@gated-at.bofh.it> (Linus Torvalds's
 message of "Thu, 05 Jun 2003 18:00:17 +0200")
Message-ID: <frodoid.frodo.873cioa34p.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <20030605125013$41ac@gated-at.bofh.it>
	<20030605160017$10e1@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

Hello Linus,

> What the _f*ck_ is wrong with just calling it "PCI domain". It's a fine 
> word, and yes, "domain" is used commonly in computer language, but that's 
> a _good_ thing. Everybody immediately understands what it is about.

Actually... I might have a problem with it. The really large Sun
Enterprise Servers have "Dynamic System Domains", DNS is made of
"domains", there are "SCSI domains", in NIS you set up a "domain",
virtual hosts at ISPs are sometimes just referred to as "domains" (ok,
it's silly sales talk, but it's there) and I sometimes put my code
into the "public domain".

The point is: Work into some place where there are Sun Enterprise
Servers with Dynamic System Domains, SCSI, DNS, Webservers
(incl. virtual hosts) on it and NSS is set up to NIS, get told by
somebody that "a domain is experiencing problems" and start sighing.

Even better: work on some foreign code that is using all various kind
of domains and start getting crazy!

"Ah, yes, this symbol is declared as 'struct l_d_domain *ldd1' - what
f***ing kind of domain IS IT?"

Yes, there are common words with common meaning. For example, an
interrupt is in most cases basically just an interrupt. Okay, there
are different types of interrupts... hardware, software,
edge-triggered, level-triggered, XT PIC, that new MSI kind you are
currently talking about or even interrupts which have nothing to do
with the processor but are just some software implementation on a
larger application. But those are just subtypes of interrupts, they
all share common, unambigious sense.

With domains it's not that easy. A dynamic system domain is a set of
ressources, a PCI domain is a set of PCI busses, but after those it's
getting a little bit unsharp. What is a DNS domain? Simply a set of
records? But DNS is also a hierarchical system with domains in a
hierarchical organisation, which doesn't really apply to e.g. PCI. In
PCI, you don't have domains below domains, you have busses below
domains. With NIS it gets tricky: what is a NIS domain? "A set of
users, groups and various other networkwide information"? What is an
Win2k domain? "A set of... well, Active Directory stuff?"

If we start to introduce more and more domains, the time will come
where our world is full of domains - and we long lost track of what
domains belong to what.

> There is no goodness to acronyms where you have to be some "insider" to 
> know what the hell it means. That "hose" thing has the same problem: I 
> don't know about anybody else, but to me a "hose" is a logn narrow conduit 
> for water, and a "PCI hose" doesn't much make sense to me.

I agree there, "hose" just sounds strange and also doesn't make much
sense to me. Is it pouring spashes data into my PCI cards or what does
that word try to explain?

> A "phb" just makes me go "Whaa?"

But people doing computer stuff *love* abbrevations. Ask any
non-kernel-developer (or non-kernel-interested) about ACPI, MSI, MSWR,
MTRR, APIC, IO-APIC, TSC, PTE or XT-PIC-IRQ and he will not only go
"Whaa?" but "WHAAAAHELP!" :-)

Eliminate all strange sounding and unobvious abbrevation from the
kernel source and the size will at least double ;-)

Even (or even especially) the most cryptic abbrevation helps
establishing some sort of unambiguousness. Those who need to know will
know, those who don't won't care.

I for my part would love to have "phb" instead of "domain" in the
kernel. Since everytime I'll get a message from kernel that says
something about "phb", I'm just gonna say "Aaah, it's PCI". If it just
states something about a "domain", I'll just gonna yell "WHAT KIND OF
DOMAIN, YOU **&%&/".

Just my 0.02 eurocents - it's your kernel

Regards,
Julien
