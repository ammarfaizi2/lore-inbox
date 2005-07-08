Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVGHWMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVGHWMn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbVGHWKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:10:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4792 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262901AbVGHWIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:08:23 -0400
Date: Fri, 8 Jul 2005 15:08:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
       christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <20050708145953.0b2d8030.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0507081505230.17536@g5.osdl.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
 <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Jul 2005, Andrew Morton wrote:
> > 
> > The previous value here i386 is 1000 --- so why is the default 250.
> 
> Because 1000 is too high.

Yes. I chose 1000 originally partly as a way to make sure that people that
assumed HZ was 100 would get a swift kick in the pants. That meant making
a _big_ change, not a small subtle one. For example, people tend to react
if "uptime" suddenly says the machine has been up for a hundred days (even
if it's really only been up for ten), but if it is off by just a factor of
two, it might be overlooked.

So 1kHz was a bit of an overkill, but it worked well enough that we never 
really got around to changing it. 

			Linus
