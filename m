Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRADGqZ>; Thu, 4 Jan 2001 01:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRADGqP>; Thu, 4 Jan 2001 01:46:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45316 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129348AbRADGqI>;
	Thu, 4 Jan 2001 01:46:08 -0500
Date: Wed, 3 Jan 2001 22:28:07 -0800
Message-Id: <200101040628.WAA01899@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: weigand@immd1.informatik.uni-erlangen.de
CC: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, ton@de.ibm.com
In-Reply-To: <200101012215.XAA20190@faui11.informatik.uni-erlangen.de>
	(message from Ulrich Weigand on Mon, 1 Jan 2001 23:15:26 +0100 (MET))
Subject: Re: [RFC, PATCH] TLB flush changes for S/390
In-Reply-To: <200101012215.XAA20190@faui11.informatik.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
   Date: 	Mon, 1 Jan 2001 23:15:26 +0100 (MET)

    * Is there some reason why ptep_test_and_clear_young should
      *not*, after all, flush the TLB?

Yes, because the accuracy of that state bit is not required to
be %100 perfect.  Less SMP tlb flushing traffic from vmscan
runs is desirable, thus no flush.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
