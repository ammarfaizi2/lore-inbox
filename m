Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbWGHVn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbWGHVn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 17:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWGHVn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 17:43:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50322 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030407AbWGHVn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 17:43:56 -0400
Date: Sat, 8 Jul 2006 14:43:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Krzysztof Halasa <khc@pm.waw.pl>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <20060708204925.GA5440@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0607081442440.3869@g5.osdl.org>
References: <m34pxt8emn.fsf@defiant.localdomain>
 <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
 <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org> <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
 <Pine.LNX.4.64.0607071456430.3869@g5.osdl.org> <20060708204925.GA5440@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jul 2006, Pavel Machek wrote:
> 
> Actually, because volatile is big hammer, it can be used to work
> around compiler bugs. If compiler dies at internal error in function
> foo, just sprinkle few volatiles into it, and you can usually work
> around that compiler problem.

Heh. That's probably an even better use of "volatile" than using it for 
hiding bugs in the sources. The bugs in the sources you'd be better off 
just _fixing_, while the compiler problems you may have a much harder time 
working around..

		Linus
