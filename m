Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbUADBnF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 20:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUADBnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 20:43:05 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:17087
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264441AbUADBnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 20:43:02 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Date: Sun, 4 Jan 2004 12:42:47 +1100
User-Agent: KMail/1.5.3
Cc: Soeren Sonnenburg <kernel@nn7.de>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local>
In-Reply-To: <20040103233518.GE3728@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401041242.47410.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004 10:35, Willy Tarreau wrote:
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
> a different manner. 

Not quite. The scheduler retains high priority for X for longer so it's no new 
dynamic adjustment of any sort, just better cpu usage by X (which is why it's 
smoother now at nice 0 than previously). 

> If either the scheduler or xterm was a bit smarter or 
> used different thresholds, the problem would go away. It would also explain
> why there are people who cannot reproduce it. Perhaps a somewhat faster or
> slower system makes the problem go away. Honnestly, it's the first time
> that I notice that my xterms are jump-scrolling, it was so much fluid
> anyway.

Very thorough but not a scheduler problem as far as I'm concerned. Can you not 
disable smooth scrolling and force jump scrolling?

Con

