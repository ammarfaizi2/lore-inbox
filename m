Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272193AbSITCGa>; Thu, 19 Sep 2002 22:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272635AbSITCGa>; Thu, 19 Sep 2002 22:06:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3737 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272193AbSITCG3>;
	Thu, 19 Sep 2002 22:06:29 -0400
Date: Thu, 19 Sep 2002 19:01:54 -0700 (PDT)
Message-Id: <20020919.190154.57630807.davem@redhat.com>
To: ak@suse.de
Cc: akpm@digeo.com, taka@valinux.co.jp, alan@lxorguk.ukuu.org.uk,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020920040619.A30304@wotan.suse.de>
References: <20020920032346.A22949@wotan.suse.de>
	<20020919.182739.48496975.davem@redhat.com>
	<20020920040619.A30304@wotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 20 Sep 2002 04:06:19 +0200

   > See "montdq/movnti", the latter of which even works on register
   > registers.  Ben LaHaise pointed this out to me earlier today.
   
   The issue is that you really want to do prefetching in these loops
   (waiting for the hardware prefetch is too slow because it needs several
   cache misses to trigger) so for cache hints on reading only prefetch
   instructions are interesting.
   
I'm talking about using this to bypass the cache on the stores.
The prefetches are a seperate issue and I agree with you on that.
