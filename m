Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUGOPVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUGOPVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 11:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266217AbUGOPVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 11:21:54 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:58002 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266216AbUGOPVw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 11:21:52 -0400
Subject: Re: tcp_window_scaling degrades performance
From: Kasper Sandberg <lkml@metanurb.dk>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1956423367.20040715170937@dns.toxicfilms.tv>
References: <1956423367.20040715170937@dns.toxicfilms.tv>
Content-Type: text/plain
Date: Thu, 15 Jul 2004 17:21:51 +0200
Message-Id: <1089904911.15291.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey, are you having some kind of hardware router?
bert hubert, helped me, and we found out my router was causing me the
problems, however, my problems were more severe, as my limit was 50kb/s

On Thu, 2004-07-15 at 17:09 +0200, Maciej Soltysiak wrote:
> Hi
> 
> I have been experiencied weird problems with network throughput
> lately and I after experimenting with /proc/sys/net/ipv4 knobs
> I found that when I have tcp_window_scaling 0 I can
> get throughput from a distant server of about 600kB/s (well, 200kB/s
> is fast enough)
> 
>    # links ftp://ftp.task.gda.pl/ls-lR
> 
> When I turn tcp_window_scaling to 1 the transfer starts with 600kB,
> then drops nicely to 20kB/s then starts growing again and reaches
> about 400kB/s
> 
> Anyway It works, but there are some hosts, with which I can't talk to
> faster than 800B/s !
> 
> This is a Debian SID with vanilla-2.6.7-bk20, but I am having these
> problems for a few weeks now.
> 
> It might be a TCP kernel issue, but I know that between me and the
> other hosts is a checkpoint fw-1 fp3, it may be the cause of problems,
> because, well, checkpoint is crazy.
> 
> Anyway, I can provide tcpdump, and tcptrace analysis of it and the
> state of sysctls if anyone would be willing to help me figure out
> what's going on.
> 
> Regards,
> Maciej
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

