Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318714AbSHEQzy>; Mon, 5 Aug 2002 12:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318716AbSHEQzx>; Mon, 5 Aug 2002 12:55:53 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:46050 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318714AbSHEQzw>;
	Mon, 5 Aug 2002 12:55:52 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15694.44775.232380.718847@napali.hpl.hp.com>
Date: Mon, 5 Aug 2002 09:59:19 -0700
To: frankeh@watson.ibm.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, <davidm@hpl.hp.com>,
       <gh@us.ibm.com>, <Martin.Bligh@us.ibm.com>, <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <200208041530.24661.frankeh@watson.ibm.com>
References: <Pine.LNX.4.44.0208041131380.10314-100000@home.transmeta.com>
	<200208041530.24661.frankeh@watson.ibm.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 4 Aug 2002 15:30:24 -0400, Hubertus Franke <frankeh@watson.ibm.com> said:

  Hubertus> Yes, if we (correctly) assume that page coloring only buys
  Hubertus> you significant benefits for small associative caches
  Hubertus> (e.g. <4 or <= 8).

This seems to be a popular misconception.  Yes, page-coloring
obviously plays no role as long as your cache no bigger than
PAGE_SIZE*ASSOCIATIVITY.  IIRC, Xeon can have up to 1MB of cache and I
bet that it doesn't have a 1MB/4KB=256-way associative cache.  Thus,
I'm quite confident that it's possible to observe significant
page-coloring effects even on a Xeon.

	--david
