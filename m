Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310429AbSCLGIM>; Tue, 12 Mar 2002 01:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310430AbSCLGIC>; Tue, 12 Mar 2002 01:08:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1735 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310429AbSCLGHz>;
	Tue, 12 Mar 2002 01:07:55 -0500
Date: Mon, 11 Mar 2002 22:04:25 -0800 (PST)
Message-Id: <20020311.220425.51167805.davem@redhat.com>
To: rgooch@ras.ucalgary.ca
Cc: bcrl@redhat.com, whitney@math.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200203111948.g2BJmhs13326@vindaloo.ras.ucalgary.ca>
In-Reply-To: <20020310212210.A27870@redhat.com>
	<20020310.183033.67792009.davem@redhat.com>
	<200203111948.g2BJmhs13326@vindaloo.ras.ucalgary.ca>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Gooch <rgooch@ras.ucalgary.ca>
   Date: Mon, 11 Mar 2002 12:48:43 -0700

   David S. Miller writes:
   > NAPI is really only going to help with high packet rates not with
   > thinks like raw bandwidth tests.
   
   You're saying that people should just go and use jumbo frames? Isn't
   that a problem for mixed 10/100/1000 LANs?

No, I'm saying that the current situation is fine with most cards
and most uses.

Ben pointed out that interrupt-mitigation challenged cards like the
NatSemi do gain, but that is the only case I can imagine at this
time.

Unless you have a card like the NatSemi (no interrupt mitigation) or
your interfaces are being hit with 120,000 packets per second EACH,
then NAPI is not going to be an explosive gain for you.

Look, we were able to get world records in web serving without NAPI,
right? :-)
