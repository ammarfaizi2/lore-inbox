Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbTIOS7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 14:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbTIOS7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 14:59:45 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28687 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261350AbTIOS7m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 14:59:42 -0400
Date: Mon, 15 Sep 2003 14:50:38 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <1063633696.2674.20.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1030915144507.20945E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003, Alan Cox wrote:

> On Llu, 2003-09-15 at 13:11, Bill Davidsen wrote:
> > The code to disable prefetch on Athlon is 300 bytes and hurts your PIV?
> > Really? I'll dig back through the code, but I recall it as adding or
> > deleting an entry in a table to enable prefetch. If it's affecting PIV the
> > code to use prefetch is seriously broken.
> 
> Big time. Its over 300 bytes long because its embedded in each inline
> prefetch and it causes a branch misprediction almost every time. Amazing
> what you find when you actually measure stuff 8)
> 
> So right now, its faster on PIV to delete the prefetch than use the
> current hack, and adding the Athlon fix makes Athlon and PIV faster and
> total memory size lower.

Of course if you have PIV kernel you don't need any of the Athlon code at
all, so the size and performance penalty is zero. And if you build for a
CPU which doesn't have prefetch you don't need any of that code at all.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

