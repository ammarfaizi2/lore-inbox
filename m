Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262234AbRENDac>; Sun, 13 May 2001 23:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262240AbRENDaW>; Sun, 13 May 2001 23:30:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55728 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262234AbRENDaL>;
	Sun, 13 May 2001 23:30:11 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15103.20768.588746.495042@pizda.ninka.net>
Date: Sun, 13 May 2001 20:29:36 -0700 (PDT)
To: kuznet@ms2.inr.ac.ru
Cc: mike_phillips@urscorp.com, linux-kernel@vger.kernel.org
Subject: Re: skb->truesize > sk->rcvbuf == Dropped packets
In-Reply-To: <200105131834.WAA28023@ms2.inr.ac.ru>
In-Reply-To: <15089.61095.23597.82875@pizda.ninka.net>
	<200105131834.WAA28023@ms2.inr.ac.ru>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kuznet@ms2.inr.ac.ru writes:
 > >  > Any suggestions on heuristics for this ? 
 > 
 > Not to set rcvbuf to ridiculously low values. The best variant is not
 > to touch SO_*BUF options at all.

Hmmm... I don't see how not touching buffer values can solve his
problem at all.  His MTU is really HUGE, and in this case 300 byte
packet eats 10k or so space in receive buffer.

I doubt our buffer size tuning algorithms can cope with this.

Really, copy threshold in driver just must be choosen carefully.

Later,
David S. Miller
davem@redhat.com
