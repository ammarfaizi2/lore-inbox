Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUEVR2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUEVR2M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 13:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUEVR2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 13:28:12 -0400
Received: from impact.colo.mv.net ([199.125.75.20]:5096 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP id S261723AbUEVR2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 13:28:08 -0400
Message-ID: <40AF8D9B.2080904@nerdvest.com>
Date: Sat, 22 May 2004 12:27:55 -0500
From: Bryan Andersen <bryan@nerdvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Timothy Miller <theosib@hotmail.com>
CC: linux-kernel@vger.kernel.org, miller@techsource.com
Subject: Re: [OT] Linux stability despite unstable hardware
References: <BAY1-F135u0T4Dk5Je6000264da@hotmail.com>
In-Reply-To: <BAY1-F135u0T4Dk5Je6000264da@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> I have had some issues recently with memory errors when using aggressive 
> memory timings.  Although memory tests pass fine, gcc would tend to 
> crash and would generate incorrect code when compiling other things. Gcc 
> couldn't even build itself properly under those conditions.
> 
> The really interesting thing is that the Linux kernel was totally 
> unaffected.  Compiling the Linux kernel is often thought of as a 
> stressful thing for a system, yet compiling a kernel with a broken gcc 
> on a system with intermittent memory errors goes through error free, and 
> the kernel is 100% stable when running.
> 
> But until the memory errors were fixed, things like KDE wouldn't build 
> without gcc crashing.
> 
> So, what is it about Linux that makes it build properly with a broken 
> GCC and run perfectly despite memory errors?

It could just be heat buildup in an critical area when under sustained 
heavy load.  It may take a while for enough heat to build up to cause 
problems.  I just recently found one of these.  It would take 4-6 hours 
of heavy intensive processing before an error would happen.  I placed a 
fan pointing at the motherboard chipset and memory to keep them cooler 
and the problem seams to have gone away.

For testing I wrote a script that kept compiling the kernel again and 
agian in a while(true) loop.  Effectively a repeat until crash loop. 
For each compile it saved the stdout/stderr output and diffed it against 
the first run.  Any differnces were flagged for checking latter.

- Bryan
