Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313862AbSDPUA5>; Tue, 16 Apr 2002 16:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313864AbSDPUA4>; Tue, 16 Apr 2002 16:00:56 -0400
Received: from splat.lanl.gov ([128.165.17.254]:40111 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S313862AbSDPUAz>; Tue, 16 Apr 2002 16:00:55 -0400
Date: Tue, 16 Apr 2002 14:00:45 -0600
From: Eric Weigle <ehw@lanl.gov>
To: "X.Xiao" <joyhaa@yahoo.com>
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: tcp/ip stack in user space (possible FAQ addition?)
Message-ID: <20020416200045.GO3651@lanl.gov>
In-Reply-To: <20020416185419.52395.qmail@web13208.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Eric-Unconspiracy: There ought to be a conspiracy
X-Editor: Vim, http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i want to move tcp/ip stack(including routing and
> netfilter) to userspace, my goal is to trace all the
> instructions involved in a firewall and router since i
> don't know how to trace these instructions inside the
> kernel. i want to get something like:
> 
> incoming ip packets(a file)-->fake ISR-->tcp/ip
> stack-->outgoing ip packets( to /dev/null).
> 
> my question is: is it possible and relatively easy to
> move tcp/ip stack to user space?
This comes up fairly frequently, it might be a good addition to the FAQ.
Here's my attempt at an answer culled from prior messages.

Several people have user-mode network stacks at various levels of
development, but it is *highly* unlikely for them ever to get into
the kernel proper (see the monolithic versus microkernel debate at
http://www.kernel.org/pub/linux/docs/lkml/#s15-4).

Here are some URLs to which you can refer for more information:
	http://www.cl.cam.ac.uk/Research/SRG/netos/arsenic/
	http://www.cs.nwu.edu/~pdinda/minet/minet.html
	http://www.joerch.org/tcpip/
	http://freshmeat.net/projects/libutcp/

However, for security purposes, you probably do not want a user-mode stack.
You want an extensible packet handling mechanism, and can be found with:
	iptables/ipchains -- the native Linux firewalling tools,
		http://netfilter.samba.org/
	tc -- the Traffic control program,
		http://www.sparre.dk/pub/linux/tc/
	libpcap -- packet capture library,
		http://www.tcpdump.org

Thanks,
-Eric

-- 
--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
