Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274848AbRIZG6j>; Wed, 26 Sep 2001 02:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274850AbRIZG63>; Wed, 26 Sep 2001 02:58:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36760 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274848AbRIZG6U>;
	Wed, 26 Sep 2001 02:58:20 -0400
Date: Tue, 25 Sep 2001 23:57:18 -0700 (PDT)
Message-Id: <20010925.235718.95903768.davem@redhat.com>
To: akpm@zip.com.au
Cc: dipankar@in.ibm.com, marcelo@connectiva.com.br, riel@connectiva.com.br,
        andrea@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        hawkes@engr.sgi.com
Subject: Re: Locking comment on shrink_caches()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BB16834.4393EEA3@zip.com.au>
In-Reply-To: <20010926103424.A8893@in.ibm.com>
	<3BB16834.4393EEA3@zip.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Tue, 25 Sep 2001 22:31:32 -0700
   
   Here are kumon's test results from March, with and without
   the hashed lock patch:

Please elaborate on what the webbench-3.0 static gets was
really doing.

Was this test composed of multiple accesses to the same or a small set
of files?  If so, that is indeed the case where the page cache locking
patches won't help at all.

The more diversified the set of files being accessed, the greater the
gain from the locking changes.  You have to encourage the cpus at
least have a chance at accessing different hash chains :-)

Franks a lot,
David S. Miller
davem@redhat.com
