Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267806AbTAHN74>; Wed, 8 Jan 2003 08:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267810AbTAHN74>; Wed, 8 Jan 2003 08:59:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:3210
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267806AbTAHN7z>; Wed, 8 Jan 2003 08:59:55 -0500
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m
	ore than 8 CPUs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Cleverdon'" <jamesclv@us.ibm.com>,
       "'Pallipadi, Venkatesh'" <venkatesh.pallipadi@intel.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Martin Bligh'" <mbligh@us.ibm.com>,
       "'John Stultz'" <johnstul@us.ibm.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "'Mallick, Asit K'" <asit.k.mallick@intel.com>,
       "'Saxena, Sunil'" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       "'Andi Kleen'" <ak@suse.de>, "'Hubert Mantel'" <mantel@suse.de>
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C022BD8BA@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C022BD8BA@usslc-exch-4.slc.unisys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042037621.24099.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 08 Jan 2003 14:53:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 18:58, Protasevich, Natalie wrote:
> 1) place pin_2_irq and the one that fixes the ACPI case (and which I haven't
> found yet) in our sub-arch making those routines platform defined

Does  cpu_to_pci_irq() pci_to_cpu_irq() work for this. That is sort of
the equivalent we have in mapping functions for other purposes. You
could then do the 16 irq shift, while other platforms would define it
in default/*.h to be a nop. 

> Another one that I am worried about is XTPR, hopefully someone is looking at
> its implementation... 

XPTR I really don't know anything about alas.

