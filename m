Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTJXURh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 16:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTJXURh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 16:17:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:43183 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262589AbTJXURf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 16:17:35 -0400
Date: Fri, 24 Oct 2003 13:17:31 -0700
From: cliff white <cliffw@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nick's scheduler v17
Message-Id: <20031024131731.29ae599a.cliffw@osdl.org>
In-Reply-To: <3F996B10.4080307@cyberone.com.au>
References: <3F996B10.4080307@cyberone.com.au>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Oct 2003 04:10:24 +1000
Nick Piggin <piggin@cyberone.com.au> wrote:

> Hi,
> http://www.kerneltrap.org/~npiggin/v17/
> 
> Still working on SMP and NUMA. Some (maybe) interesting things I put in are
> - Sequential CPU balancing so you don't get a big storm of balances 
> every 1/4s.
> - Balancing is trying to err more on the side of caution, I have to start
>   analysing it more thoroughly though.
> - Attacked the NUMA balancing code. There should now be less buslocked ops /
>   cache pingpongs in some fastpaths. Volanomark likes it, more realistic 
> loads
>   won't improve so much http://www.kerneltrap.org/~npiggin/v17/volano.png
>   This improvement is NUMA only.
> 
> I haven't had time to reproduce Cliff's serious reaim performance 
> dropoffs so
> they're probably still there. I couldn't reproduce Martin's kernbench 
> dropoff,
> but the 16-way I'm using only has 512K cache which might not show it up.
> 
Okay, i put both v17 patches in the OSDL Patch Lifecycle Manager 
( http://www.osdl.org/plm-cgi/plm/ ) 
sched-v17 is PLM #2251
sched-nopolicy-v17 is PLM #2252

Results asap.
cliffw

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
