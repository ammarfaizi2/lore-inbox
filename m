Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267825AbTBVGwm>; Sat, 22 Feb 2003 01:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267826AbTBVGwm>; Sat, 22 Feb 2003 01:52:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5078 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267825AbTBVGwl>;
	Sat, 22 Feb 2003 01:52:41 -0500
Date: Fri, 21 Feb 2003 22:46:44 -0800 (PST)
Message-Id: <20030221.224644.118785184.davem@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200302220048.h1M0mjCu020837@turing-police.cc.vt.edu>
References: <200302212125.h1LLPgxE001759@81-2-122-30.bradfords.org.uk>
	<1045874822.25411.3.camel@rth.ninka.net>
	<200302220048.h1M0mjCu020837@turing-police.cc.vt.edu>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Valdis.Kletnieks@vt.edu
   Date: Fri, 21 Feb 2003 19:48:45 -0500
   
   2) Temporary queueing congestion causes your *first* SYN to be dropped
   on the floor.  So if you send a second without ECN, you really can't
   tell if it worked because of the second SYN working Just Because, or
   because ECN was turned off.  On the other hand, you get the same
   connection as if you had done ECN-off to begin with (just 1 transmit
   later).

This is totally broken behavior.  Features don't get turned off
just because of a temporary queue overflow at some intermediate
router.

This is why the workarounds are broken by design.  This kind of
behavior is totally anti- the most basic principles of how the
internet works.
