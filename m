Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129900AbRBAAgF>; Wed, 31 Jan 2001 19:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129946AbRBAAf4>; Wed, 31 Jan 2001 19:35:56 -0500
Received: from [195.71.115.196] ([195.71.115.196]:36422 "HELO
	demdwug7.mediaways.net") by vger.kernel.org with SMTP
	id <S129900AbRBAAfm>; Wed, 31 Jan 2001 19:35:42 -0500
Date: Thu, 1 Feb 2001 01:37:04 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Robert Siemer <siemer@panorama.hadiko.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0 (updated patch)
In-Reply-To: <20010201003032U.siemer@panorama.hadiko.de>
Message-ID: <Pine.LNX.4.21.0102010115390.2065-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(cc's shortened, not to trash Linus et al)

On Thu, 1 Feb 2001, Robert Siemer wrote:

> Is it possible to directly ask the 'IRQ-router' (namely the
> ISA-bridge) for what it is set up for? - I mean which IRQ is routed to
> what without the help of the BIOS?

It's written in the PCI config registers of the router. That's what I've
tried to document in the patch according to the chipset datasheet.
The BIOS in contrast uses link values, which are vendor-specific,
undocumented and sometimes wrong ;-)
But we have to rely on these unless we have the chipset docs to make it
better - hopefully.

> There is a BIOS update for my board out there. Are you interested in
> the difference? - I would give it a try.

Might be intresting _if_ you find something unexpected like new link
values. But I don't expect any surprise. You should end up with something
similar to Aaron - including the misleading mutual IDE/USB conflict
warning. But everythin fine.

> What is the relation between IRQ routing in the ISA-brigde and the
> APIC?

APIC is a different approach to route IRQ's which is used on PII based
systems and newer (IIRC). So it doesn't matter in your case.

Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
