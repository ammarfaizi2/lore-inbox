Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbTLESm0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbTLESm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:42:26 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:17556
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S264299AbTLESmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:42:25 -0500
Subject: Re: Linux GPL and binary module exception clause?
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
       Nick Piggin <piggin@cyberone.com.au>, Paul Adams <padamsdev@yahoo.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0312050853200.9125@home.osdl.org>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
	 <3FCFCC3E.8050008@cyberone.com.au>
	 <16336.2094.950232.375620@wombat.chubb.wattle.id.au>
	 <3FD00CD2.2020900@cyberone.com.au>
	 <16336.16523.259812.642087@wombat.chubb.wattle.id.au>
	 <Pine.LNX.4.58.0312050853200.9125@home.osdl.org>
Content-Type: text/plain
Message-Id: <1070649742.15655.15.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 05 Dec 2003 10:42:23 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-05 at 09:19, Linus Torvalds wrote:
> But when you use that code to create an "elaboration" to the kernel, that
> makes it a derived work, and you cannot distribute it except as laid out
> by the GPL. A binary module is one such case, but even just a source patch
> is _also_ one such case. The lines you added are yours, but when you
> distribute it as an elaboration, you are bound by the restriction on
> derivative works.
> 
> Or you had better have some other strong argument why it isn't. Which has
> been my point all along.

I tend to agree, but there is a counter-argument:

You can't copyright "facts".  A header file contains facts about the
kernel within it, particularly once it has been compiled into machine
code.  In machine code, it is simply things like integers (the sizes and
offsets of things, other constants), and encoded entrypoints (however
function calls back into the kernel end up looking).  A binary
containing facts about the kernel is not a derived work of the kernel,
even if those facts came from headers in the kernel source.  

To argue against this, you'd have to demonstrate that the original
author of the header file had some creative input into the machine code
of the module, on order for the module to be considered a derived work
of the header.  

You could so far as saying that if every header put a chunk of text
(say, a piece of poetry) into each .o file which used that header, then
there'd be a much stronger case for saying the .o is derived from the
header. 

I've had long complex arguments with legal types over whether function
names are creative ("flumulate_my_greeble" is the best function name
ever!) or mere facts (the function name is simply a cookie you need to
refer to to call a function - it doesn't matter what the name actually
is).

	J

