Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265184AbSJRPSH>; Fri, 18 Oct 2002 11:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265187AbSJRPSG>; Fri, 18 Oct 2002 11:18:06 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:56550 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S265184AbSJRPSG>; Fri, 18 Oct 2002 11:18:06 -0400
Message-ID: <004d01c276bb$39b32980$2a060e09@beavis>
From: "Andrew Theurer" <habanero@us.ibm.com>
To: <trond.myklebust@fys.uio.no>, "Hirokazu Takahashi" <taka@valinux.co.jp>
Cc: <neilb@cse.unsw.edu.au>, <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, <nfs@lists.sourceforge.net>
References: <001301c275e6$f31d5970$2a060e09@beavis><20021018.012618.74755132.taka@valinux.co.jp><shs8z0w1f3k.fsf@charged.uio.no> <20021018.161952.41628057.taka@valinux.co.jp>
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
Date: Fri, 18 Oct 2002 10:12:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >      > Congestion avoidance mechanism of NFS clients might cause this
> >      > situation.  I think the congestion window size is not enough
> >      > for high end machines.  You can make the window be larger as a
> >      > test.
> >
> > The congestion avoidance window is supposed to adapt to the bandwidth
> > that is available. Turn congestion avoidance off if you like, but my
> > experience is that doing so tends to seriously degrade performance as
> > the number of timeouts + resends skyrockets.
>
> Yes, you must be right.
>
> But I guess Andrew may use a great machine so that the transfer rate
> has exeeded the maximum size of the congestion avoidance window.
> Can we determin preferable maximum window size dynamically?

Is this a concern on the client only?  I can run a test with just one client
and see if I can saturate the 100Mbit adapter.  If I can, would we need to
make any adjustments then?  FYI, at 115 MB/sec total throughput, that's only
2.875 MB/sec for each of the 40 clients.  For the TCP result of 181 MB/sec,
that's 4.525 MB/sec, IMO, both of which are comfortable throughputs for a
100Mbit client.

Andrew Theurer

