Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131612AbQLVCrf>; Thu, 21 Dec 2000 21:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131714AbQLVCrY>; Thu, 21 Dec 2000 21:47:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62850 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131612AbQLVCrL>;
	Thu, 21 Dec 2000 21:47:11 -0500
Date: Thu, 21 Dec 2000 18:00:15 -0800
Message-Id: <200012220200.SAA05057@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: kernel@pineview.net
CC: linux-kernel@vger.kernel.org
In-Reply-To: <977453684.3a42c2744fbb7@ppro.pineview.net> (message from Mike
	OConnor on Fri, 22 Dec 2000 13:24:44 +1100 (CST))
Subject: Re: No more DoS
In-Reply-To: <977453684.3a42c2744fbb7@ppro.pineview.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Fri, 22 Dec 2000 13:24:44 +1100 (CST)
   From: Mike OConnor <kernel@pineview.net>

   I would like to point who ever is in charge of the TCP stack for
   the linux kernel at a site which claims to have a method of
   eliminate denial of service (DoS) attacks

   http://grc.com/r&d/nomoredos.htm

   With my limited unstanding of TCP and DoS attacks this would seem
   to be the answer, instead of a work around.

These people claim that no connection state needs to be saved for the
beginning of the negotiation, and I claim this is unworkable because
it ignores TCP timestamps entirely.

Furthermore, it also cannot work because it makes retransmissions
of the SYN/ACK very non-workable.  I suppose his TCP stack just hacks
around this by just waiting for the original client SYN to get
retransmitted or something like this.  I question whether that can
even work reliably.

I think not holding onto any state for an incoming SYN is nothing but
a dream in any serious modern TCP implementation.  It can be reduced,
but not eliminated.  The former is what most modern stacks have done
to fight these problems.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
