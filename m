Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284017AbRLRE3W>; Mon, 17 Dec 2001 23:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285130AbRLRE3M>; Mon, 17 Dec 2001 23:29:12 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:1950 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S284017AbRLRE26>; Mon, 17 Dec 2001 23:28:58 -0500
To: Zameer.Ahmed@gs.com ("Ahmed, Zameer")
Cc: linux-kernel@vger.kernel.org
Subject: Re: Turning off nagle algorithm in 2.2.x and 2.4.x kernels?
In-Reply-To: <FBC7494738B7D411BD7F00902798761908BFF190@gsny49e.ny.fw.gs.com>
From: Andi Kleen <ak@muc.de>
Date: 18 Dec 2001 05:27:49 +0100
In-Reply-To: Zameer.Ahmed@gs.com's message of "Mon, 17 Dec 2001 21:06:14 +0000 (UTC)"
Message-ID: <m3bsgxup8a.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zameer.Ahmed@gs.com ("Ahmed, Zameer") writes:

> Hi,
> 	Is there a way to turn off nagle compression in the kernel for 2.2.x
> and 2.4.x kernels? For the same custom app used under Solaris and Linux.
> Turning off nagle algorithm boosted perf on Solaris, I tried commenting out
> 
> #bool 'IP: Disable NAGLE algorithm (normally enabled)' CONFIG_TCP_NAGLE_OF
> 
> from the net/ipv4/Config.in 2.2.19 kernel and still the degradation in
> network performance for packts in midsize persists
> I tried the 2.4.16 kernel. This gave me very slight improvement, but not
> quite what is expected.

Read the tcp(7) manpage.  Enabling the TCP_NODELAY socket option disables
nagle per socket. The Config option is a noop and hasn't done anything for
a long time.

-Andi

