Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268511AbRH1UBa>; Tue, 28 Aug 2001 16:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268954AbRH1UBV>; Tue, 28 Aug 2001 16:01:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15498 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268511AbRH1UBQ>;
	Tue, 28 Aug 2001 16:01:16 -0400
Date: Tue, 28 Aug 2001 13:01:10 -0700 (PDT)
Message-Id: <20010828.130110.26275634.davem@redhat.com>
To: ak@suse.de
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <oup8zg4j8u0.fsf@pigdrop.muc.suse.de>
In-Reply-To: <20010828180108Z16193-32383+2058@humbolt.nl.linux.org.suse.lists.linux.kernel>
	<Pine.LNX.4.33.0108281110540.8754-100000@penguin.transmeta.com.suse.lists.linux.kernel>
	<oup8zg4j8u0.fsf@pigdrop.muc.suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 28 Aug 2001 21:14:15 +0200
   
   At least something seems to be broken in it. I did run some 900MB processes
   on a 512MB machine with 2.4.9 and kswapd took between 70 and 90% of the CPU
   time.

That's all swapmap lookup stupidity, you'll see __get_swap_page()
near the top of your profiles.  The algorithm is just sucky.

Later,
David S. Miller
davem@redhat.com
