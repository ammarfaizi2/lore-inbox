Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287769AbSBCVej>; Sun, 3 Feb 2002 16:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287781AbSBCVea>; Sun, 3 Feb 2002 16:34:30 -0500
Received: from mx2.elte.hu ([157.181.151.9]:1409 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287769AbSBCVeZ>;
	Sun, 3 Feb 2002 16:34:25 -0500
Date: Sun, 3 Feb 2002 22:34:22 +0100
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 NFS hangup
Message-ID: <20020203213422.GA703@csoma.elte.hu>
In-Reply-To: <20020203202251.GA22797@csoma.elte.hu> <shsbsf61di3.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shsbsf61di3.fsf@charged.uio.no>
User-Agent: Mutt/1.3.27i
X-Accept-Language: en, hu
From: "=?iso-8859-2?Q?Burj=E1n_G=E1bor?=" 
	<buga+dated+1013031263.c89449@elte.hu>
X-Delivery-Agent: TMDA/0.43 (Python 2.1.1+; linux2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Feb 03, Trond Myklebust wrote:

> Nothing abnormal there or in your file. However, when you start
> getting 'server not responding' messages, and no tcpdump output it's
> usually a sign that the networking layer has given up on you. Any
> strange output from 'netstat -s'?

Output is here: http://www.csoma.elte.hu/~burjang/netstat-s-20020203.out

I think `1710 reassemblies required' may be strange after boot...
How can I figure out what causes this?

> It would be useful to know what networking card/driver combination you
> are using? Any firewalls/netfilter setups? Any special mount options?

eth0: PCnet/PCI II 79C970A at 0x1020, 08 00 5a f8 82 e7
pcnet32: pcnet32_private lp=c0591000 lp_dma_addr=0x80591000 assigned IRQ 15.
pcnet32.c:v1.25kf 17.11.2001 tsbogend@alpha.franken.de

(this card is an integrated AMD pcnet32 in a 43P-140)

There are no firewalls or packet filters.  I didn't specify any
special mount options for nfs:

partvis:~$ cat /proc/mounts
/dev/root / nfs rw,v2,rsize=4096,wsize=4096,hard,udp,nolock,addr=157.181.150.31 0 0
proc /proc proc rw 0 0
partvis:~$

	buga
