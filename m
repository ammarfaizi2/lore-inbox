Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbRFMJBv>; Wed, 13 Jun 2001 05:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbRFMJBl>; Wed, 13 Jun 2001 05:01:41 -0400
Received: from ns.suse.de ([213.95.15.193]:46856 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S261550AbRFMJBa>;
	Wed, 13 Jun 2001 05:01:30 -0400
To: Michal Margula <alchemyx@uznam.net.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disaster under heavy network load on 2.4.x
In-Reply-To: <20010611220301.A6852@cerber.uznam.net.pl.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Jun 2001 11:01:18 +0200
In-Reply-To: Michal Margula's message of "11 Jun 2001 22:12:27 +0200"
Message-ID: <oupr8wolpnl.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Margula <alchemyx@uznam.net.pl> writes:

> Hello!
> 
> My friend told me to noticed you about problems I had with 2.4.x line of
> kernels. I started up from 2.4.3. Under heavy load I was getting
> messages from telnet, ping, nmap "No buffer space available". Strace
> told me it was error marked as ENOBUFS.

You probably need to increase various sysctls to handle your load. 
E.g. /proc/sys/net/ipv4/tcp_mem, net/core/[rw]mem_{max,default}, neigh/
defaults/gc_thresh* (for the ARP table) 


> 
> First thought was it was my fault. I asked many people and nobody could
> help me. So I tried 2.4.5. It was a disaster also (should I mention few
> oopses?:>).

When you have oopses run them through ksymoops and send them to the list.

 
-Andi
