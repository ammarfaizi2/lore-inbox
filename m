Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbRCBRxN>; Fri, 2 Mar 2001 12:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRCBRxD>; Fri, 2 Mar 2001 12:53:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37127 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129363AbRCBRw5>; Fri, 2 Mar 2001 12:52:57 -0500
Date: Fri, 2 Mar 2001 09:52:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@cambridge.redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable 
In-Reply-To: <8165.983522444@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.10.10103020949230.25951-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Mar 2001, David Howells wrote:
> 
> Surely, doing the merge will always have take longer than not doing the merge,
> no matter how finely optimised the algorithm... But merging wouldn't be done
> very often... only on memory allocation calls.

Ehh.. If the merging doesn't actually happen, it's always a loss. We've
just spent CPU cycles on doing something useless. And in my tests, that
was the case a lot more than not.

Also, in the expense of taking a page fault, looking one or two levels
deeper in the AVL tree is pretty much not noticeable. 

Show me numbers for real applications, and I might care. I saw barely
measurable speedups (and more importantly to me - real simplification) by
removing it.

Don't bother arguing with "it might.."

		Linus

