Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbUADAN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUADAN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:13:28 -0500
Received: from mail.mediaways.net ([193.189.224.113]:30563 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S264375AbUADANG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:13:06 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Soeren Sonnenburg <kernel@nn7.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Con Kolivas <kernel@kolivas.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
In-Reply-To: <20040103233518.GE3728@alpha.home.local>
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>
	 <200401040800.06529.kernel@kolivas.org>
	 <1073164240.9851.319.camel@localhost>
	 <200401040815.54655.kernel@kolivas.org>
	 <20040103233518.GE3728@alpha.home.local>
Content-Type: text/plain
Message-Id: <1073175082.9851.358.camel@localhost>
Mime-Version: 1.0
Date: Sun, 04 Jan 2004 01:11:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-04 at 00:35, Willy Tarreau wrote:
> On Sun, Jan 04, 2004 at 08:15:54AM +1100, Con Kolivas wrote:
[...]
> 6) Conclusion
> =============
> 
> Under 2.4, xterm uses jump scrolling which it does not use by default under
> 2.6 if X responds fast enough. The first dirty solution which comes to mind
> is to renice X to >+10 to slow it a bit so that xterm hits the high water
> level and jumps.
> 
> But it's not an effect of the scheduler alone, but a side effect of the
> scheduler and xterm both trying to automatically adjust their behaviour in
> a different manner. If either the scheduler or xterm was a bit smarter or
> used different thresholds, the problem would go away. It would also explain
> why there are people who cannot reproduce it. Perhaps a somewhat faster or
> slower system makes the problem go away. Honnestly, it's the first time that
> I notice that my xterms are jump-scrolling, it was so much fluid anyway.

Hmmhh, indeed I could reproduce that here.
However I am using multi-gnome-terminal and I've heard of others
observing this issue using gnome-terminal. 
As they are probably all derived from xterm I now do wonder how to fix
them in such a way that it works smoothly with 2.4 and 2.6.

Soeren.

