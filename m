Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265045AbSJRHVJ>; Fri, 18 Oct 2002 03:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265047AbSJRHVJ>; Fri, 18 Oct 2002 03:21:09 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:55562 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S265045AbSJRHVE>;
	Fri, 18 Oct 2002 03:21:04 -0400
Date: Fri, 18 Oct 2002 16:19:52 +0900 (JST)
Message-Id: <20021018.161952.41628057.taka@valinux.co.jp>
To: trond.myklebust@fys.uio.no
Cc: habanero@us.ibm.com, neilb@cse.unsw.edu.au, davem@redhat.com,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <shs8z0w1f3k.fsf@charged.uio.no>
References: <001301c275e6$f31d5970$2a060e09@beavis>
	<20021018.012618.74755132.taka@valinux.co.jp>
	<shs8z0w1f3k.fsf@charged.uio.no>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>      > Congestion avoidance mechanism of NFS clients might cause this
>      > situation.  I think the congestion window size is not enough
>      > for high end machines.  You can make the window be larger as a
>      > test.
> 
> The congestion avoidance window is supposed to adapt to the bandwidth
> that is available. Turn congestion avoidance off if you like, but my
> experience is that doing so tends to seriously degrade performance as
> the number of timeouts + resends skyrockets.

Yes, you must be right.

But I guess Andrew may use a great machine so that the transfer rate
has exeeded the maximum size of the congestion avoidance window.
Can we determin preferable maximum window size dynamically?

Thank you,
Hirokazu Takahashi.
