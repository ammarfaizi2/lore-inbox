Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130903AbRCJDZd>; Fri, 9 Mar 2001 22:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130904AbRCJDZY>; Fri, 9 Mar 2001 22:25:24 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:37375 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130903AbRCJDZK>; Fri, 9 Mar 2001 22:25:10 -0500
Date: Fri, 09 Mar 2001 19:11:57 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
To: Gérard Roudier <groudier@club-internet.fr>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        "David S. Miller" <davem@redhat.com>,
        Russell King <rmk@arm.linux.org.uk>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <000c01c0a90f$df0627a0$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.LNX.4.10.10103092150260.1818-100000@linux.local>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     The reverse mapping
> > code hast to be less than 0.1KB.
> 
> If reverse mapping means bus_to_virt(), then I would suggest not to
> provide it since it is a confusing interface. OTOH, only a few drivers
> need or want to retrieve the virtual address that lead to some bus dma

Your SCSI code went the other way; the logic is about the same.
That's easy enough ... I'm not going to argue that point any longer.

The driver might even have Real Intelligence to apply.  But I wonder
how many assumptions drivers will end up making about those dma
mappings.  It may be important to expose the "logical" page size to
the driver ("don't cross 4k boundaries"); currently it's hidden.

Other than that L1_CACHE goof, it seems this was the main thing
needing to change in the I API sent by.  Sound right?  Implementation
would be a different question.  I'm not in the least attached to what
I sent by, but some implementation is needed.  Slab-like, or buddy? :)


> Does 'usable' apply to Java applications ? :-)

Servers and other non-gui tools?  I don't see why not.  You can make
good systems software in many languages.  There are advantages to
not having those classes of memory-related bugs.  I'm looking forward
to GCC 3.0 with GCJ, compiling Java just like C.  But that's OT.

- Dave


