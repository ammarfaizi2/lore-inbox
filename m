Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274596AbSITBcT>; Thu, 19 Sep 2002 21:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274603AbSITBcT>; Thu, 19 Sep 2002 21:32:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50840 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274596AbSITBcS>;
	Thu, 19 Sep 2002 21:32:18 -0400
Date: Thu, 19 Sep 2002 18:27:39 -0700 (PDT)
Message-Id: <20020919.182739.48496975.davem@redhat.com>
To: ak@suse.de
Cc: akpm@digeo.com, taka@valinux.co.jp, alan@lxorguk.ukuu.org.uk,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020920032346.A22949@wotan.suse.de>
References: <p73lm5xtqyv.fsf@oldwotan.suse.de>
	<3D8A754E.5BA2E28D@digeo.com>
	<20020920032346.A22949@wotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 20 Sep 2002 03:23:46 +0200

   On Thu, Sep 19, 2002 at 06:09:34PM -0700, Andrew Morton wrote:
   > Can you control the cachability of the memory reads as well?
   
   SSE2 has hints for that (prefetchnti and even prefetcht0,1 etc. for different
   cache hierarchies), but it's not completely clear on how much
   the CPUs follow these. 
   
   For writing it's much more obvious and usually documented even.

See "montdq/movnti", the latter of which even works on register
registers.  Ben LaHaise pointed this out to me earlier today.
