Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270001AbSITCBU>; Thu, 19 Sep 2002 22:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272193AbSITCBU>; Thu, 19 Sep 2002 22:01:20 -0400
Received: from ns.suse.de ([213.95.15.193]:24592 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S270001AbSITCBT>;
	Thu, 19 Sep 2002 22:01:19 -0400
Date: Fri, 20 Sep 2002 04:06:19 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, akpm@digeo.com, taka@valinux.co.jp, alan@lxorguk.ukuu.org.uk,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
Message-ID: <20020920040619.A30304@wotan.suse.de>
References: <p73lm5xtqyv.fsf@oldwotan.suse.de> <3D8A754E.5BA2E28D@digeo.com> <20020920032346.A22949@wotan.suse.de> <20020919.182739.48496975.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020919.182739.48496975.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> See "montdq/movnti", the latter of which even works on register
> registers.  Ben LaHaise pointed this out to me earlier today.

The issue is that you really want to do prefetching in these loops
(waiting for the hardware prefetch is too slow because it needs several
cache misses to trigger) so for cache hints on reading only prefetch
instructions are interesting.

-Andi
