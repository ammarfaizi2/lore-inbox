Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131243AbRAYVcm>; Thu, 25 Jan 2001 16:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131850AbRAYVcc>; Thu, 25 Jan 2001 16:32:32 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:59407 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S131243AbRAYVcU>;
	Thu, 25 Jan 2001 16:32:20 -0500
From: Steve Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200101252129.VAA13948@gw.chygwyn.com>
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
To: davem@redhat.com (David S. Miller)
Date: Thu, 25 Jan 2001 21:29:44 +0000 (GMT)
Cc: ionut@cs.columbia.edu (Ion Badulescu), kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, andrewm@uow.EDU.AU (Andrew Morton)
In-Reply-To: <14960.38705.859136.36297@pizda.ninka.net> from "David S. Miller" at Jan 25, 2001 01:14:25 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX8 6NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Do you mean that devices will not be able to indicate support of SG seperately
from hw checksum or that the IP zerocopy will simply ignore devices which
do not have both ?

DECnet assumes that the mac level checksum will detect all errors and does
not have a checksum of its own on data, so it would only need SG to benefit
from the zerocopy framework,

Steve.

> 
> 
> Ion Badulescu writes:
>  > I'm just wondering, if a card supports sg but *not* TX csum, is it worth
>  > it to make use of sg? eepro100 falls into this category..
> 
> No, not worth it for now.  In fact I'm going to mark that combination
> (sg without csum) as illegal in the final zerocopy patch I end up
> sending to Linus.
> 
> Later,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
