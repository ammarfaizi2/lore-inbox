Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbSJQQ13>; Thu, 17 Oct 2002 12:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261677AbSJQQ12>; Thu, 17 Oct 2002 12:27:28 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:1034 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S261665AbSJQQ11>;
	Thu, 17 Oct 2002 12:27:27 -0400
Date: Fri, 18 Oct 2002 01:26:18 +0900 (JST)
Message-Id: <20021018.012618.74755132.taka@valinux.co.jp>
To: habanero@us.ibm.com
Cc: neilb@cse.unsw.edu.au, davem@redhat.com, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <001301c275e6$f31d5970$2a060e09@beavis>
References: <003301c275e1$0bf76810$2a060e09@beavis>
	<20021017.222602.48536782.taka@valinux.co.jp>
	<001301c275e6$f31d5970$2a060e09@beavis>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > How about IP datagrams?  You can see the IP fields in /proc/net/snmp
> > IP layer may also discard them.
> 
> Server:
> 
> Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors ForwDatagrams
> InUnknownProtos InDiscards InDelivers OutRequests OutDiscards OutNoRoutes
> ReasmTimeout ReasmReqds ReasmOKs ReasmFails FragOKs FragFails FragCreates
> Ip: 1 64 4088714 0 0 720 0 0 4086393 12233109 2 0 0 0 0 0 0 0 6000000
> 
> A Client:
> 
> Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors ForwDatagrams
> InUnknownProtos InDiscards InDelivers OutRequests OutDiscards OutNoRoutes
> ReasmTimeout ReasmReqds ReasmOKs ReasmFails FragOKs FragFails FragCreates
> Ip: 2 64 2115252 0 0 0 0 0 1115244 646510 0 0 0 1200000 200008 0 0 0 0

It looks fine.  
Hmmm....  What version of linux do you use?

Congestion avoidance mechanism of NFS clients might cause this situation.
I think the congestion window size is not enough for high end machines.
You can make the window be larger as a test.
