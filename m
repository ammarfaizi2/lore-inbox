Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbVGHXEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbVGHXEF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbVGHXC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:02:26 -0400
Received: from dvhart.com ([64.146.134.43]:34997 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262952AbVGHW7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:59:42 -0400
Date: Fri, 08 Jul 2005 15:59:35 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <133660000.1120863575@flay>
In-Reply-To: <20050708145953.0b2d8030.akpm@osdl.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org><20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's been over two weeks and nobody has complained about anything.
> 
>> 
>> > [PATCH] i386: Selectable Frequency of the Timer Interrupt
>> 
>> [...]
>> 
>> > +choice
>> > +	prompt "Timer frequency"
>> > +	default HZ_250
>> 
>> WHAT?
>> 
>> The previous value here i386 is 1000 --- so why is the default 250.
> 
> Because 1000 is too high.
> 
>> Now that this has hit mainline please consider applying:
> 
> We might indeed do that.  But if nobody continues to notice anything, we
> might not.  We'll see.

I noticed something ... the fact that elapsed times on kernel compiles
etc got significantly faster with lower HZ values ... see for example

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/kernbench.elm3b67.png

Sorry, it's getting a bit scrunched in there ... I need to make it bigger
and filter old details stuff out better.

I think we're talking between 2.6.12-git5 and 2.6.12-git6 right? I can
confirm more explicitly if really need be. 48s -> 45.5s elapsed.

M.

