Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286383AbRLJVFu>; Mon, 10 Dec 2001 16:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286388AbRLJVFq>; Mon, 10 Dec 2001 16:05:46 -0500
Received: from mtiwmhc26.worldnet.att.net ([204.127.131.51]:24312 "EHLO
	mtiwmhc26.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S286383AbRLJVF3>; Mon, 10 Dec 2001 16:05:29 -0500
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: John Clemens <john@deater.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112101016140.15280-100000@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.33.0112101016140.15280-100000@pianoman.cluster.toy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 10 Dec 2001 12:56:00 -0800
Message-Id: <1008017762.17062.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 07:26, John Clemens wrote:
> I've updated my bios on my Pavilion N5430 and guess what is shows on
> the bios boot screen (if you disable the bios splash screen)... Omnibook
> XE3.  They are one in the same, at least model number wise.  weird,
> considering there are no AMD omnibooks..

The DMI info is suspiciously similar to ours, as well. Same "Board
Version"...

> Good luck.. I emailed HP support, and got the "we're forwarding your
> request to the BIOS people".. and that was 4 months ago.

They never gave you a case number?

> Ohh, and Marcelo accepted the K7/SSE patch for 2.4.17, so no need for that
> patch anymore..

Woohoo!

> I will try the ACPI PCI routing stuff if i get time tonight (don't have
> access to the machine right now).

For me, the new ACPI didn't help (just had the same table, USB on IRQ
9). And, of course, it doesn't actually do the routing, just displays it
(for now).

I'm leaning toward the "Stolen from Kai" patch over the "stolen from
you" patch. Seems a bit less hackish, and IMHO, the "correct" behavior
anyway (honoring the irq mask). Of course, that could bite us on PIR
tables with bad masks. Thoughts?

-Cory

