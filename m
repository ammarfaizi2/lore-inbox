Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTAXVLn>; Fri, 24 Jan 2003 16:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbTAXVLn>; Fri, 24 Jan 2003 16:11:43 -0500
Received: from packet.digeo.com ([12.110.80.53]:7899 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265736AbTAXVLm>;
	Fri, 24 Jan 2003 16:11:42 -0500
Date: Fri, 24 Jan 2003 13:39:56 -0800
From: Andrew Morton <akpm@digeo.com>
To: rwhron@earthlink.net
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: big ext3 sequential write improvement in 2.5.51-mm1 gone in
 2.5.53-mm1?
Message-Id: <20030124133956.029c4b89.akpm@digeo.com>
In-Reply-To: <20030124211906.GA15788@rushmore>
References: <20030124211906.GA15788@rushmore>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 21:20:48.0792 (UTC) FILETIME=[771E9180:01C2C3EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
>
> > It is important to specify how much memory you have, and how you are
> > invoking qsbench.
> 
> There is 3.75 GB of ram.  I grab MemTotal from /proc/meminfo, and run
> 4 qsbench processes.  Each qsbench uses 30% of MemTotal (1089 megs).  

Yes, 2.5 sucks at that.  Run `top', observe how in 2.4, one qsbench instance
grabs all the CPU time, then exits.  The remaining three can now complete
with no swapout at all..
