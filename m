Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130235AbRAUKDM>; Sun, 21 Jan 2001 05:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131315AbRAUKDC>; Sun, 21 Jan 2001 05:03:02 -0500
Received: from chiara.elte.hu ([157.181.150.200]:12806 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130235AbRAUKCs>;
	Sun, 21 Jan 2001 05:02:48 -0500
Date: Sun, 21 Jan 2001 11:02:15 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: James Sutherland <mandrake@cam.ac.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Roman Zippel <zippel@fh-brandenburg.de>,
        Kai Henningsen <kaih@khms.westfalen.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.30.0101210945220.8238-100000@dax.joh.cam.ac.uk>
Message-ID: <Pine.LNX.4.30.0101211058130.2844-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Jan 2001, James Sutherland wrote:

> For many applications, yes - but think about a file server for a
> moment. 99% of the data read from the RAID (or whatever) is really
> aimed at the appropriate NIC - going via main memory would just slow
> things down.

patently wrong. Compare the bandwidth of PCI and the bandwidth of memory
controllers. It's both slower, has higher latency and uses up more
valuable (PCI) bandwidth to do PCI->PCI transfers. The number of
situations where PCI->PCI transactions are the preferred method are *very*
limited, and i think we should deal with them when we see them. But this
has been said at the very beginning of this thread already, please read it
all ...

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
