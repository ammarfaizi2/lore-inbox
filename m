Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317503AbSFDXya>; Tue, 4 Jun 2002 19:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317504AbSFDXy3>; Tue, 4 Jun 2002 19:54:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:33788 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317503AbSFDXy2>; Tue, 4 Jun 2002 19:54:28 -0400
Subject: RE: [patch] i386 "General Options" - begone [take 2]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Dave Jones'" <davej@suse.de>, "'Pavel Machek'" <pavel@suse.cz>,
        Brad Hards <bhards@bigpond.net.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7ED9@orsmsx111.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jun 2002 02:00:04 +0100
Message-Id: <1023238804.12671.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-05 at 00:09, Grover, Andrew wrote:
> All I can say is using just *part* of ACPI will cause some machine,
> somewhere, to not work.

We've established that pretty comprehensively. Any bit of ACPI causes
some machines somewhere to not work 8)

> I want to avoid scenarios where that happens. If
> there are issues with that, can we discuss them asap, perhaps now?

It may be that the IRQ routing and other bits of ACPI logic need to know
that their are dependancies. We handle that already for other legacy
stuff. If you don't have an MCA bus we don't do MCA bus enumerating. If
you don't have a PCI BIOS32 irq router we don't consider that option and
so forth. Having ACPI IRQ/Enumeration code that says if(!acpi) return
NULL isnt that demanding

