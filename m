Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130882AbRATSJF>; Sat, 20 Jan 2001 13:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130579AbRATSIz>; Sat, 20 Jan 2001 13:08:55 -0500
Received: from quattro.sventech.com ([205.252.248.110]:1548 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S130217AbRATSIv>; Sat, 20 Jan 2001 13:08:51 -0500
Date: Sat, 20 Jan 2001 13:08:49 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inefficient PCI DMA usage (was: [experimental patch] UHCI updates)
Message-ID: <20010120130848.I9156@sventech.com>
In-Reply-To: <3A69D235.F1EE4CA6@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <3A69D235.F1EE4CA6@colorfullife.com>; from Manfred Spraul on Sat, Jan 20, 2001 at 07:00:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001, Manfred Spraul <manfred@colorfullife.com> wrote:
> > 
> > TD's are around 32 bytes big (actually, they may be 48 or even 64 now, I 
> > haven't checked recently). That's a waste of space for an entire page. 
> > 
> > However, having every driver implement it's own slab cache seems a 
> > complete waste of time when we already have the code to do so in 
> > mm/slab.c. It would be nice if we could extend the generic slab code to 
> > understand the PCI DMA API for us. 
> >
> I missed the beginning of the thread:
> 
> What are the exact requirements for TD's?
> I have 3 tiny updates for mm/slab.c that I'll send to Linus as soon as
> 2.4 has stabilized a bit more, perhaps I can integrate the code for USB.

They need to be visible via DMA. They need to be 16 byte aligned. We
also have QH's which have similar requirements, but we don't use as many
of them.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
