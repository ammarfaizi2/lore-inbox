Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262746AbTCJHtE>; Mon, 10 Mar 2003 02:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262747AbTCJHtE>; Mon, 10 Mar 2003 02:49:04 -0500
Received: from packet.digeo.com ([12.110.80.53]:54224 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262746AbTCJHtD>;
	Mon, 10 Mar 2003 02:49:03 -0500
Date: Mon, 10 Mar 2003 00:00:14 -0800
From: Andrew Morton <akpm@digeo.com>
To: J Sloan <joe@tmsusa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: slab error in 2.5.64-mm4
Message-Id: <20030310000014.64de2f36.akpm@digeo.com>
In-Reply-To: <3E6C3075.4040408@tmsusa.com>
References: <3E6C3075.4040408@tmsusa.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Mar 2003 07:59:36.0855 (UTC) FILETIME=[FE99DA70:01C2E6DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan <joe@tmsusa.com> wrote:
>
> This may be of interest -
> 
> kernel: 2.5.64-mm4
> 
> Linux distro: Red Hat 8.0 + updates
> 
> Hardware:
> Celeron 1.2 Ghz on genuine Intel Motherboard, 512 MB RAM
> 
> Just recompiled 2.5.64-mm4 with full debugging
> and saw a slab error right after bringing up the
> ethernet interfaces -
> 
> Full kernel log attached, but the meat of it is here:
> 
> Mar  9 21:42:54 jyro kernel: Slab corruption: start=dfc15964, 
> expend=dfc159e3, problemat=dfc1599c
> Mar  9 21:42:54 jyro kernel: Last user: [<00000000>](0x0)

Drat.  We should _not_ have a zero here.  Without this info we know next to
nothing.

Please ensure that you have CONFIG_FRAME_PONTER enabled.  But the slab
diagnostic seems to work OK here without that.

Oh well.  It'll come again.

