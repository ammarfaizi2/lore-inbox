Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316864AbSFDWJF>; Tue, 4 Jun 2002 18:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316877AbSFDWJE>; Tue, 4 Jun 2002 18:09:04 -0400
Received: from ns.suse.de ([213.95.15.193]:24324 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316864AbSFDWJB>;
	Tue, 4 Jun 2002 18:09:01 -0400
Date: Wed, 5 Jun 2002 00:09:02 +0200
From: Dave Jones <davej@suse.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Pavel Machek'" <pavel@suse.cz>, Brad Hards <bhards@bigpond.net.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386 "General Options" - begone [take 2]
Message-ID: <20020605000902.A4751@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	'Pavel Machek' <pavel@suse.cz>, Brad Hards <bhards@bigpond.net.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7ED8@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<trivial patchbot removed from Cc:>

On Tue, Jun 04, 2002 at 02:58:35PM -0700, Grover, Andrew wrote:

 > So, let's assume in the very near future it becomes possible to compile a
 > kernel without MPS or $PIR support. Where should those config options go?

Why do they need to be options ? They should be implied if CONFIG_ACPI=n
Otherwise we could build a kernel without any PCI IRQ routing, MPS
discovery etc.. I can't see the benefit of making this stuff compile
time optional other than to save a few bytes (and there are much better
places to start attacking to save space than this).

 > These, in addition to pnpbios, are also unneeded with ACPI.

As long as the target box has working ACPI tables and we don't have
to fall back to legacy tables.
 
 > That is why I
 > was advocating the more general "Platform interface options" menu, so we
 > could have *one* place to config these and ACPI in or out, instead of having
 > the many different platform interface options in different logical areas.

Can you confirm that you're not advocating a "ACPI or Legacy" approach ?
I think you're aware of the dragons that lie that way, but I want to be
sure my suspicions are unfounded.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
