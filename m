Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129528AbRBARfE>; Thu, 1 Feb 2001 12:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130641AbRBARez>; Thu, 1 Feb 2001 12:34:55 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32015 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130340AbRBAReX>; Thu, 1 Feb 2001 12:34:23 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
To: hch@caldera.de (Christoph Hellwig)
Date: Thu, 1 Feb 2001 17:34:49 +0000 (GMT)
Cc: sct@redhat.com (Stephen C. Tweedie), lord@sgi.com (Steve Lord),
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010201180237.A28007@caldera.de> from "Christoph Hellwig" at Feb 01, 2001 06:02:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ONdD-0004gz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm in the middle of some parts of it, and am actively soliciting
> > feedback on what cleanups are required.  
> 
> The real issue is that Linus dislikes the current kiobuf scheme.
> I do not like everything he proposes, but lots of things makes sense.

Linus basically designed the original kiobuf scheme of course so I guess
he's allowed to dislike it. Linus disliking something however doesn't mean
its wrong. Its not a technically valid basis for argument.

Linus list of reasons like the amount of state are more interesting

> > So, what are the benefits in the disk IO stack of adding length/offset
> > pairs to each page of the kiobuf?
> 
> I don't see any real advantage for disk IO.  The real advantage is that
> we can have a generic structure that is also usefull in e.g. networking
> and can lead to a unified IO buffering scheme (a little like IO-Lite).

Networking wants something lighter rather than heavier. Adding tons of
base/limit pairs to kiobufs makes it worse not better

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
