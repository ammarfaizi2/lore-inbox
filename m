Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268967AbTBWUIZ>; Sun, 23 Feb 2003 15:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268969AbTBWUIZ>; Sun, 23 Feb 2003 15:08:25 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:33756 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S268967AbTBWUIX>; Sun, 23 Feb 2003 15:08:23 -0500
Date: Sun, 23 Feb 2003 17:18:19 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: oom killer and its superior braindamage in 2.4
In-Reply-To: <200302231833.05944.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.50L.0302231715090.2206-100000@imladris.surriel.com>
References: <200302222025.48129.m.c.p@wolk-project.de>
 <Pine.LNX.4.50L.0302221711100.2206-100000@imladris.surriel.com>
 <Pine.LNX.4.50L.0302221732010.2206-100000@imladris.surriel.com>
 <200302231833.05944.m.c.p@wolk-project.de>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003, Marc-Christian Petersen wrote:

> > Does the below patch fix your problem ?

> With your patch, mystress.pl was marked to get killed, every PID only
> once, no apache or similar (good). ... But the strange thing is, that it
> seems none of the processes, which are marked to be killed, get killed.
> So sysrq-t tells me.

It'd be interesting to know where these processes are spending
their CPU time and why they're not catching their signals.

> Sysrq-i gave me the chance to get out of the OOM killing process and
> only kernel threads were left + getty's so I was able to log in again.

Strange, so sysrq-i manages to kill the processes, but the OOM
killer doesn't kill the processes ?

This is very suspect because the OOM killer uses force_sig in
the same way the sysrq-i handler does...

regards,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
