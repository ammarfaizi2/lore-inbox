Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293505AbSCEWui>; Tue, 5 Mar 2002 17:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292968AbSCEWuS>; Tue, 5 Mar 2002 17:50:18 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24326 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S292971AbSCEWuB>; Tue, 5 Mar 2002 17:50:01 -0500
Date: Tue, 5 Mar 2002 17:48:26 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: jt@hpl.hp.com
cc: paulus@samba.org, linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PPP feature request (Tx queue len + close)
In-Reply-To: <20020304144200.A32397@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.3.96.1020305174147.28907A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Jean Tourrilhes wrote:

> Tx queue length
> ---------------
> 	Problem : IrDA does its buffering (IrTTP is a sliding window
> protocol). PPP does its buffering (1 packet in ppp_generic +
> dev->tx_queue_len = 3). End result : a large number of packets queued
> for transmissions, which result in some network performance issues.
> 
> 	Solution : could we allow the PPP channel to overwrite
> dev->tx_queue_len ?
> 	This is similar to the channel beeing able to set the MTUs and
> other parameters...

Random thoughts on this:
- ifconfig sets txlength, and could channels get into contention?
- if you reduce buffers too far performance sucks.
- did you look at just reducing the packet size (MTU)?

You should really use the above methods to diddle parameters and
benchmark. If nothing else you can point to numbers as a reason to make
any change.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

