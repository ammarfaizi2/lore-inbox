Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281696AbRKZO22>; Mon, 26 Nov 2001 09:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281705AbRKZO2T>; Mon, 26 Nov 2001 09:28:19 -0500
Received: from firebird.planetinternet.be ([195.95.34.5]:37642 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S281696AbRKZO2B>; Mon, 26 Nov 2001 09:28:01 -0500
Date: Mon, 26 Nov 2001 15:27:54 +0100
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: deathlock in kswapd using 2.4.15
Message-ID: <20011126152754.A1205@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I got back to my box, it didn't respond anymore.  With
alt+scroll lock, I always got an EIP near this one.

The output from ksymoops:

Pid: 5, comm:                kswapd
EIP: 0010:[<c013be87>] CPU: 0 EFLAGS: 00000216    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: [<c013bf33>] [<c0125dc8>] [<c0125dfc>] [<c0125e93>]
[<c0125eee>] [<c0125ffd>] [<c010546c>]
Warning (Oops_read): Code line not seen, dumping what data is
available

>>EIP; c013be86 <prune_icache+36/c8>   <=====
Trace; c013bf32 <shrink_icache_memory+1a/30>
Trace; c0125dc8 <shrink_caches+74/84>
Trace; c0125dfc <try_to_free_pages+24/44>
Trace; c0125e92 <kswapd_balance_pgdat+42/8c>
Trace; c0125eee <kswapd_balance+12/28>
Trace; c0125ffc <kswapd+98/bc>
Trace; c010546c <kernel_thread+28/38>


Anything else I can do?



Kurt

