Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288845AbSBDKUZ>; Mon, 4 Feb 2002 05:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288850AbSBDKUP>; Mon, 4 Feb 2002 05:20:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64452 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288845AbSBDKUI>;
	Mon, 4 Feb 2002 05:20:08 -0500
Date: Mon, 4 Feb 2002 13:16:51 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Steffen Persvold <sp@scali.com>
Cc: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Short question regarding generic_make_request()
In-Reply-To: <3C5E4CDE.9B60F077@scali.com>
Message-ID: <Pine.LNX.4.33.0202041315200.4046-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Feb 2002, Steffen Persvold wrote:

> [root@damd1 root]# ping sci4
> PING sci4 (192.168.4.4) from 192.168.4.3 : 56(84) bytes of data.
> 64 bytes from sci4 (192.168.4.4): icmp_seq=0 ttl=255 time=238 usec

> For simplicity I'll say ~200usec. When I change the receive handler
> from a tasklet to a kernel thread, the numbers look like this :
>
> [root@damd1 root]# ping sci4
> PING sci4 (192.168.4.4) from 192.168.4.3 : 56(84) bytes of data.
> 64 bytes from sci4 (192.168.4.4): icmp_seq=0 ttl=255 time=4.215 msec
> 64 bytes from sci4 (192.168.4.4): icmp_seq=1 ttl=255 time=5.728 msec

this shows some sort of wakeup or softirq handling irregularity. A number
of softirq latency bugs were fixed, i'd suggest to try this with any
recent kernel (or recent errata kernel rpms).

	Ingo

