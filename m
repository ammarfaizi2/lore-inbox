Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTIOSxk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 14:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTIOSxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 14:53:40 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:26639 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261296AbTIOSxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 14:53:39 -0400
Date: Mon, 15 Sep 2003 14:44:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: John Bradford <john@grabjohn.com>, piggin@cyberone.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zwane@linuxpower.ca
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <1063633514.3734.17.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1030915143144.20945D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003, Alan Cox wrote:

> On Llu, 2003-09-15 at 11:54, John Bradford wrote:
> > In the model I'm proposing, the 386 kernel would be missing the Athlon
> > workarounds.
> 
> This is unworkable unless you also have all the existing models where
> you have fixes for later processors too. 

I think John wants to have the default be that only code for the target
CPU be included in the kernel when built for a given CPU. There's no
reason why someone building for 386 would want code for other CPUs at all,
vendors and people who want to run a single suboptimal kernel on multiple
machines.

My own suggestion is that the default could continue to be "include
anything which doesn't break or drastically slow the target CPU," and then
have a flag value to exclude fixups or enhancements for other CPUs. This
allows existing code to be gradully marked for simplification by embedded
users or those who just want to avoid overhead in their kernel.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

