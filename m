Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131197AbRBEMBn>; Mon, 5 Feb 2001 07:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131817AbRBEMBc>; Mon, 5 Feb 2001 07:01:32 -0500
Received: from colorfullife.com ([216.156.138.34]:30213 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131197AbRBEMBN>;
	Mon, 5 Feb 2001 07:01:13 -0500
Message-ID: <3A7E95F3.38B26DC@colorfullife.com>
Date: Mon, 05 Feb 2001 13:00:51 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify 
 + callback chains
In-Reply-To: <20010201220744.K11607@redhat.com> <Pine.LNX.4.10.10102031224210.8867-100000@penguin.transmeta.com> <20010205110336.A1167@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> You simply cannot do physical disk IO on
> non-sector-aligned memory or in chunks which aren't a multiple of
> sector size.

Why not?

Obviously the disk access itself must be sector aligned and the total
length must be a multiple of the sector length, but there shouldn't be
any restrictions on the data buffers.

I remember that even Windoze 95 has scatter-gather support for physical
disk IO with arbitraty buffer chunks. (If the hardware supports it,
otherwise the io subsystem will copy the data into a contiguous
temporary buffer)

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
