Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131633AbRBATCL>; Thu, 1 Feb 2001 14:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRBATCB>; Thu, 1 Feb 2001 14:02:01 -0500
Received: from ns.caldera.de ([212.34.180.1]:27143 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131633AbRBATBy>;
	Thu, 1 Feb 2001 14:01:54 -0500
Date: Thu, 1 Feb 2001 20:00:55 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, bsuparna@in.ibm.com,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201200055.A7182@caldera.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Stephen C. Tweedie" <sct@redhat.com>, bsuparna@in.ibm.com,
	linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010201194800.A4653@caldera.de> <E14OOvP-0004sX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <E14OOvP-0004sX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 01, 2001 at 06:57:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 06:57:41PM +0000, Alan Cox wrote:
> Not for raw I/O. Although for the drivers that can't cope then going via
> the page cache is certainly the next best alternative

True - but raw-io has it's own alignment issues anyway.

> Yes. You also need a way to describe it in terms of page * in order to do
> mm locking for raw I/O (like the video capture stuff wants)

Right. (That's why we have the struct page * always as part of the structure)

> Certainly having the lightweight one a subset of the heavyweight one is a good
> target. 

Yes, I'm trying to address that...

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
