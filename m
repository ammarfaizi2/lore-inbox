Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279879AbRJ3Fbn>; Tue, 30 Oct 2001 00:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279881AbRJ3Fbd>; Tue, 30 Oct 2001 00:31:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61824 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279879AbRJ3Fb1>;
	Tue, 30 Oct 2001 00:31:27 -0500
Date: Mon, 29 Oct 2001 21:31:57 -0800 (PST)
Message-Id: <20011029.213157.39157336.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: fokkensr@linux06.vertis.nl, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: iptables and tcpdump
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011030152812.2e9ba8ee.rusty@rustcorp.com.au>
In-Reply-To: <01102817104101.01788@home01>
	<20011030152812.2e9ba8ee.rusty@rustcorp.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Tue, 30 Oct 2001 15:28:12 +1100
   
   should the NAT layer be doing skb_unshare() before altering the packet?

I think it should.

Look, if you are messing with packets before they go back out, and
tcpdump could have sniffed it on the way in, you can't change it's
contents blindly.

Franks a lot,
David S. Miller
davem@redhat.com
