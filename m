Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129171AbQKQWO2>; Fri, 17 Nov 2000 17:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129412AbQKQWOT>; Fri, 17 Nov 2000 17:14:19 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:18180 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S129171AbQKQWOF>; Fri, 17 Nov 2000 17:14:05 -0500
Date: Fri, 17 Nov 2000 21:43:37 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        mj@suse.cz
Subject: Re: VGA PCI IO port reservations
In-Reply-To: <200011171646.QAA01224@raistlin.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10011172134510.27177-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Russell King wrote:

> Therefore, it should be reserved independent of whether we have the
> driver loaded/in kernel or not.

Is this not an argument for a more flexible resource allocation
API?  One offering both:

   res = allocate_resource(restype, dev, RES_ALLOC_UNUSED, region);

and

   res = allocate_resource(restype, dev_ RES_ALLOC_HW, region);

?

Maybe the kernel might ask:

   allocate_resource(restype, dev, RES_ALLOC_UNMOVABLE_HW, region);

Matthew.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
