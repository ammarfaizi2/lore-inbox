Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318161AbSIAX2s>; Sun, 1 Sep 2002 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSIAX2r>; Sun, 1 Sep 2002 19:28:47 -0400
Received: from holomorphy.com ([66.224.33.161]:32406 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318161AbSIAX2r>;
	Sun, 1 Sep 2002 19:28:47 -0400
Date: Sun, 1 Sep 2002 16:28:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Daniel Phillips <phillips@arcor.de>,
       Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Include LRU in page count
Message-ID: <20020901232804.GF18114@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Daniel Phillips <phillips@arcor.de>,
	Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <3D644C70.6D100EA5@zip.com.au> <20020901212943Z16578-4014+1360@humbolt.nl.linux.org> <3D729020.4DFDAC2B@zip.com.au> <E17ld5N-0004cg-00@starship> <3D729DD3.AE3681C9@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D729DD3.AE3681C9@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2002 at 04:08:03PM -0700, Andrew Morton wrote:
> My approach was to keep the existing design and warm it up, rather than to
> redesign.  Is it "good enough" now?   Dunno - nobody has run the tests
> with slablru.  But it's probably too late for a redesign (such as per-cpu LRU,
> per-mapping lru, etc).
>
> It would be great to make presence on the LRU contribute to
> page->count, because that would permit the removal of a ton of
> page_cache_get/release operations inside the LRU lock, perhaps
> doubling throughput in there.   Guess I should get off my lazy butt
> and see what you've done (will you for heaven's sake go and buy an IDE
> disk and compile up a 2.5 kernel? :))


I've at least been testing (if not at least attempting to debug)
2.5.32-mm2, which includes slablru.


Cheers,
Bill
