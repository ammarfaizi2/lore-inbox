Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131555AbRBAS6V>; Thu, 1 Feb 2001 13:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131616AbRBAS6L>; Thu, 1 Feb 2001 13:58:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23568 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131555AbRBAS5z>; Thu, 1 Feb 2001 13:57:55 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
To: hch@caldera.de (Christoph Hellwig)
Date: Thu, 1 Feb 2001 18:57:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hch@caldera.de (Christoph Hellwig),
        sct@redhat.com (Stephen C. Tweedie), bsuparna@in.ibm.com,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010201194800.A4653@caldera.de> from "Christoph Hellwig" at Feb 01, 2001 07:48:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OOvP-0004sX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It doesn't really matter that much, because we write to the pagecache
> first anyway.

Not for raw I/O. Although for the drivers that can't cope then going via
the page cache is certainly the next best alternative

> The real thing is that we want to have some common data structure for
> describing physical memory used for IO.  We could either use special

Yes. You also need a way to describe it in terms of page * in order to do
mm locking for raw I/O (like the video capture stuff wants)

> by Larry McVoy's splice paper) should allow just that, nothing more an
> nothing less.  For use in disk-io and networking or v4l there are probably
> other primary data structures needed, and that's ok.

Certainly having the lightweight one a subset of the heavyweight one is a good
target. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
