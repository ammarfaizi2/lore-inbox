Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277546AbRJJX44>; Wed, 10 Oct 2001 19:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277547AbRJJX4q>; Wed, 10 Oct 2001 19:56:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27271 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277546AbRJJX4h>;
	Wed, 10 Oct 2001 19:56:37 -0400
Date: Wed, 10 Oct 2001 16:56:59 -0700 (PDT)
Message-Id: <20011010.165659.74564935.davem@redhat.com>
To: chris@wirex.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.11 min() in tcp.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011010164430.B19995@figure1.int.wirex.com>
In-Reply-To: <20011010164430.B19995@figure1.int.wirex.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Wright <chris@wirex.com>
   Date: Wed, 10 Oct 2001 16:44:30 -0700

   tcp.c:855: warning: comparison of distinct pointer types lacks a cast
   
   the following patch, changes min() to min_t() to make size_t explicit.

Applied, but with a cleanup, please never do this:
   
   -		min(
   +		min_t (

"min_t" is not a C operator, therefore no reason to put a space
between "min_t" and the openning parenthesis.  If you look around,
this is the general coding style rule the Linux code follows:

	if ()  /* <--- space here */
	while () /* <--- and here */
	foo_function() /* <--- but not here */

For example.

Franks a lot,
David S. Miller
davem@redhat.com
