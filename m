Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSFDXKq>; Tue, 4 Jun 2002 19:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSFDXKp>; Tue, 4 Jun 2002 19:10:45 -0400
Received: from fmr02.intel.com ([192.55.52.25]:57027 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S316709AbSFDXKo>; Tue, 4 Jun 2002 19:10:44 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7ED9@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Dave Jones'" <davej@suse.de>
Cc: "'Pavel Machek'" <pavel@suse.cz>, Brad Hards <bhards@bigpond.net.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [patch] i386 "General Options" - begone [take 2]
Date: Tue, 4 Jun 2002 16:09:48 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dave Jones [mailto:davej@suse.de] 

> On Tue, Jun 04, 2002 at 02:58:35PM -0700, Grover, Andrew wrote:
>  > So, let's assume in the very near future it becomes 
> possible to compile a
>  > kernel without MPS or $PIR support. Where should those 
> config options go?
> Why do they need to be options ? They should be implied if 
> CONFIG_ACPI=n
> Otherwise we could build a kernel without any PCI IRQ routing, MPS
> discovery etc.. I can't see the benefit of making this stuff compile
> time optional other than to save a few bytes (and there are 
> much better
> places to start attacking to save space than this).

One reason is for code cleanliness. Linux's internal data structures for irq
routing and MPS stuff on i386 were not designed to handle the possibility of
multiple ways of getting this info. ACPI init gets in there and does its
thing, but it could be better architected. Making the legacy config options
removable is one way to ensure the kernel has things properly modularized
wrt this, and yes, I think someday (maybe not soon) someone *will* want to
leave out MPS support.

> Can you confirm that you're not advocating a "ACPI or Legacy" 
> approach ?
> I think you're aware of the dragons that lie that way, but I 
> want to be
> sure my suspicions are unfounded.

All I can say is using just *part* of ACPI will cause some machine,
somewhere, to not work. I want to avoid scenarios where that happens. If
there are issues with that, can we discuss them asap, perhaps now?

Regards -- Andy
