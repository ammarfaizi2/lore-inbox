Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUAESh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbUAESh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:37:58 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:47369 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265294AbUAESh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:37:56 -0500
Date: Mon, 5 Jan 2004 19:37:33 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Lincoln Dale <ltd@cisco.com>, Soeren Sonnenburg <kernel@nn7.de>,
       Con Kolivas <kernel@kolivas.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Message-ID: <20040105183733.GA2550@alpha.home.local>
References: <200401041242.47410.kernel@kolivas.org> <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local> <200401041242.47410.kernel@kolivas.org> <5.1.0.14.2.20040104195316.02151e98@171.71.163.14> <3FF7DA24.40802@cyberone.com.au> <20040104120720.GA14497@alpha.home.local> <3FF8B52B.3060003@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF8B52B.3060003@cyberone.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

during a kernel compilation today while browsing the net on another
virtual screen, I noticed extremely long delays to redraw the screen.
My setup is the following :
 - kernel 2.6.1-rc1-mm1 + w29p2
 - X either reniced to -10 or 0 (doesnt make a difference)
 - window maker
 - opera open on a fairly simple page (marc.theaimsgroup.com) in VS 1
 - 2 xterms on VS2
 - 4 xterms in VS3, one of which runs make -j 3 bzImage, another one 'top'.

-> going from VS3 to VS2 then VS1 takes up to 5 or 6 seconds redrawing
   parts of windows on each screen. I also noticed that make -j 8 dep
   blocked the xterm it was run in for about a third of a second about
   twice a second. It does not seem to slow the process however since
   it takes the same amount of time as make -j 8 dep >/dev/null.


Cheers,
Willy

