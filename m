Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSJRFcq>; Fri, 18 Oct 2002 01:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbSJRFcq>; Fri, 18 Oct 2002 01:32:46 -0400
Received: from mons.uio.no ([129.240.130.14]:31653 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262210AbSJRFcp>;
	Fri, 18 Oct 2002 01:32:45 -0400
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: habanero@us.ibm.com, neilb@cse.unsw.edu.au, davem@redhat.com,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
References: <003301c275e1$0bf76810$2a060e09@beavis>
	<20021017.222602.48536782.taka@valinux.co.jp>
	<001301c275e6$f31d5970$2a060e09@beavis>
	<20021018.012618.74755132.taka@valinux.co.jp>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Oct 2002 07:38:23 +0200
In-Reply-To: <20021018.012618.74755132.taka@valinux.co.jp>
Message-ID: <shs8z0w1f3k.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Hirokazu Takahashi <taka@valinux.co.jp> writes:

     > Congestion avoidance mechanism of NFS clients might cause this
     > situation.  I think the congestion window size is not enough
     > for high end machines.  You can make the window be larger as a
     > test.

The congestion avoidance window is supposed to adapt to the bandwidth
that is available. Turn congestion avoidance off if you like, but my
experience is that doing so tends to seriously degrade performance as
the number of timeouts + resends skyrockets.

Cheers,
  Trond
