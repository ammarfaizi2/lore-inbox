Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKVLY5>; Wed, 22 Nov 2000 06:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129150AbQKVLYr>; Wed, 22 Nov 2000 06:24:47 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:9221 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129091AbQKVLYb>;
	Wed, 22 Nov 2000 06:24:31 -0500
Date: Wed, 22 Nov 2000 11:54:25 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: David Hinds <dhinds@lahmed.Stanford.EDU>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why not PCMCIA built-in and yenta/i82365 as modules
In-Reply-To: <20001121160443.B18150@lahmed.stanford.edu>
Message-ID: <Pine.LNX.4.21.0011221150110.31073-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, David Hinds wrote:

> On Tue, Nov 21, 2000 at 11:34:45PM +0100, Tobias Ringstrom wrote:
> > The subject says it all. Is there any particular (technical) reason why I
> > must have both the generic pcmcia code and the controller support
> > built-in, or build all of them as modules?
> 
> Is there a technical reason for this?  Not that I know of; but then I
> also cannot think of a good reason for wanting, say, the generic code
> built in but the controller support as modules.  I do see reasonable
> arguments for all-builtin or all-modules.

Maybe more a matter of taste, or real life problems. I wanted a kernel
with yenta and i82365 built-in, but I need to specify extra_sockes to the
i82365. There is no way to do this unless it is a module. Then I thought,
why not have yenta build-in, and i82365 as a module, and discovered that
that was not possible. I know, I should add a __setup thingie to i82365,
but...

As for taste, the generic pcmcia code is not a driver, and it would make
sense to me to have that support in the kernel, not in a module.

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
