Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129153AbRBBOHO>; Fri, 2 Feb 2001 09:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129212AbRBBOHF>; Fri, 2 Feb 2001 09:07:05 -0500
Received: from zeus.kernel.org ([209.10.41.242]:20172 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129153AbRBBOGz>;
	Fri, 2 Feb 2001 09:06:55 -0500
Date: Fri, 2 Feb 2001 14:04:40 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>, bsuparna@in.ibm.com,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010202140440.W11607@redhat.com>
In-Reply-To: <20010201193221.D11607@redhat.com> <200102012046.VAA16746@ns.caldera.de> <20010201212508.G11607@redhat.com> <20010202125135.A12245@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010202125135.A12245@caldera.de>; from hch@caldera.de on Fri, Feb 02, 2001 at 12:51:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 02, 2001 at 12:51:35PM +0100, Christoph Hellwig wrote:
> > 
> > If I have a page vector with a single offset/length pair, I can build
> > a new header with the same vector and modified offset/length to split
> > the vector in two without copying it.
> 
> You just say in the higher-level structure ignore from x to y even if
> they have an offset in their own vector.

Exactly --- and so you end up with something _much_ uglier, because
you end up with all sorts of combinations of length/offset fields all
over the place.

This is _precisely_ the mess I want to avoid.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
