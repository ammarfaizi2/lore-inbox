Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTLNVHw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 16:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTLNVHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 16:07:44 -0500
Received: from mx1.elte.hu ([157.181.1.137]:49284 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262569AbTLNVHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 16:07:43 -0500
Date: Sun, 14 Dec 2003 22:06:56 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <Pine.LNX.4.58.0312141228170.1478@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312142205050.13533@earth>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312142032310.9900@earth>
 <Pine.LNX.4.58.0312141228170.1478@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Dec 2003, Linus Torvalds wrote:

> That code looks fragile as hell. I think you fixed a bug and it might be
> the absolutely proper fix, but I'd be happier about it if it was more
> obvious what the rules are and _why_ that is the only case that
> matters..

agreed, and we had a fair number of bugs in this area already. But i dont
know whether (or how) it could be made simpler - i think most of the
ugliness is a reflexion of the POSIX semantics. (combined with ptrace
complexities.)

	Ingo
