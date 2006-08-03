Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWHCVt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWHCVt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWHCVt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:49:29 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62695
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030199AbWHCVt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:49:28 -0400
Date: Thu, 03 Aug 2006 14:48:45 -0700 (PDT)
Message-Id: <20060803.144845.66061203.davem@davemloft.net>
To: tytso@mit.edu
Cc: mchan@broadcom.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060803201741.GA7894@thunk.org>
References: <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au>
	<1154630207.3117.17.camel@rh4>
	<20060803201741.GA7894@thunk.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Tso <tytso@mit.edu>
Date: Thu, 3 Aug 2006 16:17:41 -0400

> eth0: Tigon3 [partno(BCM95704s) rev 2100 PHY(serdes)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:14:5e:86:44:24

The 5704 chip will set TG3_FLAG_TAGGED_STATUS, and therefore
doesn't need the periodic poking done by tg3_timer().
