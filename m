Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269664AbTHBSKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 14:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269978AbTHBSKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 14:10:25 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:37650 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S269664AbTHBSKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 14:10:21 -0400
Date: Sat, 2 Aug 2003 20:10:07 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre10
Message-ID: <20030802181007.GB13525@alpha.home.local>
References: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet> <20030801224753.GA912@alpha.home.local> <1059817370.1868.5.camel@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059817370.1868.5.camel@tux.rsn.bth.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Sat, Aug 02, 2003 at 11:42:50AM +0200, Martin Josefsson wrote:
 
> Have you tried using the ULOG target and the ulogd userspace daemon?
> It uses netlink and can batch several entries together before it sends
> them to userspace. Works a lot better than syslog.

yes, I tried it about february. I thought it to be the ideal solution, and it
performed better than the standard syslog, but not as well as syslog-ng. I
could catch about 1500 lines/s at most, and the daemon was very hungry, it ate
between 55 and 70% of the CPU, while syslog-ng eats about 25-30. So I thought
it was still a bit experimental and switched to syslog-ng.

> Are you using ip_conntrack on that machine? if you are, be aware that
> ip_conntrack doesn't scale well at all on SMP. It's beeing worked on.

Yes I do. I noticed the scalability problems a long time ago on my dual athlon
at home, but wasn't really concerned. At my customer's, the only SMP one is
used as a development gateway. All the others are UP (PIII/1G, P4/2.4G).

BTW, I get the same numbers with 2.4.22-pre10 / standard ip_conntrack as with
2.4.21-rc2 with tcp_window_tracking. I would have thought that
tcp_window_tracking costs a bit more, but it doesn't seem to be noticeable here.

Cheers,
Willy

