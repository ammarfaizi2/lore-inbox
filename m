Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132654AbQLNUnY>; Thu, 14 Dec 2000 15:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133021AbQLNUnS>; Thu, 14 Dec 2000 15:43:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2185 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132654AbQLNUnD>;
	Thu, 14 Dec 2000 15:43:03 -0500
Date: Thu, 14 Dec 2000 11:55:43 -0800
Message-Id: <200012141955.LAA08814@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ionut@cs.columbia.edu
CC: mhaque@haque.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0012141204210.27848-100000@age.cs.columbia.edu>
	(message from Ion Badulescu on Thu, 14 Dec 2000 12:07:38 -0800 (PST))
Subject: Netfilter is broken (was Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback))
In-Reply-To: <Pine.LNX.4.30.0012141204210.27848-100000@age.cs.columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 14 Dec 2000 12:07:38 -0800 (PST)
   From: Ion Badulescu <ionut@cs.columbia.edu>

   I'm afraid I won't be able to answer this question, since I'm
   leaving for a 3-week vacation in about 50 minutes and I need my
   firewall functional until then. :-) Maybe other people who have
   seen this problem can experiment further.

Ok, regardless I'm very confident netfilter is doing something
very bad.

Essentially it is feeding SKBs into IPv4 receive processing which
have a NULL skb->dev, that has always been illegal.  Now it OOPSs
so we can spot such violations.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
