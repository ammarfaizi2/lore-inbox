Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269815AbRH3RTO>; Thu, 30 Aug 2001 13:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272350AbRH3RTF>; Thu, 30 Aug 2001 13:19:05 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:1034 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S269815AbRH3RSv>; Thu, 30 Aug 2001 13:18:51 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108301718.f7UHIWq19376@wildsau.idv-edu.uni-linz.ac.at>
Subject: arp.c duplicate assignment of skb->dev ("cosmetic")
To: linux-kernel@vger.kernel.org
Date: Thu, 30 Aug 2001 19:18:32 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

this is rather cosmetical than functional, but in arp.c,
in arp_send(), on line 489

	skb->dev=dev;

is assigned. in line 563, still in the same routine, it is
assigned again without skb or skb->dev being changed. so I guess
this second assignment is not neccessary. I can't see where
skb->dev is changed within the 80  lines. so, we could remove
the second assignment.

/herp

