Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUEBCAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUEBCAK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 22:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbUEBCAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 22:00:10 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:42912 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262927AbUEBCAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 22:00:06 -0400
Date: Sun, 2 May 2004 03:59:34 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: johnstul@us.ibm.com, george@mvista.com, kaukasoi@elektroni.ee.tut.fi,
       linux-kernel@vger.kernel.org
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
In-Reply-To: <20040501184105.2cd1c784.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0405020352480.26994@gockel.physik3.uni-rostock.de>
References: <403D0F63.3050101@mvista.com> <1077760348.2857.129.camel@cog.beaverton.ibm.com>
 <403E7BEE.9040203@mvista.com> <1077837016.2857.171.camel@cog.beaverton.ibm.com>
 <403E8D5B.9040707@mvista.com> <1081895880.4705.57.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de>
 <1081967295.4705.96.camel@cog.beaverton.ibm.com> <20040415103711.GA320@elektroni.ee.tut.fi>
 <Pine.LNX.4.53.0404151302140.28278@gockel.physik3.uni-rostock.de>
 <20040415161436.GA21613@elektroni.ee.tut.fi>
 <Pine.LNX.4.53.0405011540390.25435@gockel.physik3.uni-rostock.de>
 <20040501184105.2cd1c784.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004, Andrew Morton wrote:

> Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> >
> >  +#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
> 
> I think this has an inclusion ordering problem.
> 
> In file included from net/ipv6/route.c:30:
> include/linux/times.h:11:42: division by zero in #if
> include/linux/times.h:42:42: division by zero in #if                            
> 
> either NSEC_PER_SEC or USER_HZ hasn't been defined yet.
> 

Yep, we'd need to include timex.h for it. This get's messy. 

OK, I found why John's original patch didn't fix the issue, but I'd like
to hand the patch off to someone with a vision of how time shall be
handled in the kernel.

Sorry,
Tim
