Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbRB0AFW>; Mon, 26 Feb 2001 19:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRB0AFN>; Mon, 26 Feb 2001 19:05:13 -0500
Received: from lindy.SoftHome.net ([204.144.232.9]:62475 "HELO
	lindy.softhome.net") by vger.kernel.org with SMTP
	id <S129281AbRB0AE5>; Mon, 26 Feb 2001 19:04:57 -0500
Message-ID: <20010227003431.12104.qmail@lindy.softhome.net>
To: Jeremy Jackson <jerj@coplanar.net>
cc: linux-kernel@vger.kernel.org, roger@kea.grace.cri.nz
Subject: Re: tcp stalls with 2.4 (but not 2.2) 
Organization: SoftHome
X-URL: http://www.SoftHome.net/
In-Reply-To: Your message of "Mon, 26 Feb 2001 11:11:16 EST."
             <3A9A8023.7542CBF7@coplanar.net> 
Date: Mon, 26 Feb 2001 17:34:30 -0700
From: Brian Grossman <brian@SoftHome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'm seeing stalls sending packets to some clients.  I see this problem
> > under 2.4 (2.4.1 and 2.4.1ac17) but not under 2.2.17.
> 
> compiled in ECN support? SYNcookies?  try disabling through /proc
> tcp or udp? if udp check /proc/net/ipv4/ip_udpdloose or such

CONFIG_INET_ECN is not set in .config.
CONFIG_SYN_COOKIES is set, but tcp_syncookies but is set to 0.

> > My theory is there is an ICMP black hole between my server and some of its
> > clients.  Is there a tool to pinpoint that black hole if it exists?
> 
> ping is your friend.  -s lets you set size of packet. (to
> check for fragmentation) use tcpdump to capture
> a trace of this or a tcp session.

> email trace to me private if you want.

Does ping set the no fragment bit?

Ping -s 1500 to the router immediately before client's known IP address
works fine.  I'll get the owner of the client to help out later and send
those results with tcpdump to you privately.

Brian
