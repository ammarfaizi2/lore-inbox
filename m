Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319171AbSHNBqp>; Tue, 13 Aug 2002 21:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319172AbSHNBqp>; Tue, 13 Aug 2002 21:46:45 -0400
Received: from pina.terra.com.br ([200.176.3.17]:45778 "EHLO pina.terra.com.br")
	by vger.kernel.org with ESMTP id <S319171AbSHNBqo>;
	Tue, 13 Aug 2002 21:46:44 -0400
Date: Tue, 13 Aug 2002 22:50:32 -0300
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: eepro100@scyld.com, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] General network slowness on SIS 530 with eepro100
Message-ID: <20020813225032.A17293@blackjesus.async.com.br>
References: <20020813212923.L2219@blackjesus.async.com.br> <shs1y92p7ho.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <shs1y92p7ho.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Aug 14, 2002 at 03:13:55AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 03:13:55AM +0200, Trond Myklebust wrote:
> >>>>> " " == Christian Reis <kiko@async.com.br> writes:
> 
>      > Helle there,
> 
>      > I've been, for the past days, setting up a fairly big diskless
>      > network based on Linux. I've chosen to use 2.4.19 as the kernel
>      > because there were some hardware requirements, and for most of
>      > the newer boxes, it runs fine. However, for three of the older
>      > boxes, we have had some pretty odd performance and stability
>      > issues. This message is about the latest one, which is an ASUS
>      > P5S-B (has the infamous SIS 530 chipset) on an intel eepro100
>      > card. Details:
> 
> Is all this NFS over UDP? If so, numbers should not really have
> changed in 2.4.19 ( - yes my patchset changes things, but stock 2.4.19
> should not be too different w.r.t 2.4.18)
> 
> Are you able to determine where in the 2.4.19-pre series the
> performance dies?

Yes, it is over UDP. (Should I try TCP?)

Well, to be honest, I just set the network up, and I only tried two
kernels: 2.4.19 kosher and 2.4.19 with nfs-all. I haven't experimented
swapping kernels because I've been a bit singleminded that it's
something to do with the hardware setup.

I can try using an older kernel to see if it helps. 2.4.18 is a good
idea? Let me try and I'll post you back.

(BTW: Your patches *do* solve a problem I have: it makes client nfs
locking actually work; before them I had some serious issues with
locking under high network load. Not anymore. The flock() patch is also
essential for running sendmail on the diskless stations --- before it I
was forced to use tmpfs for /var/spool/mqueue.)

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
