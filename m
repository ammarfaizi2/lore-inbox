Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbTGAEDD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 00:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbTGAEDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 00:03:02 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10930 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264795AbTGAEDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 00:03:01 -0400
Date: Mon, 30 Jun 2003 21:17:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Manfred Spraul <manfred@colorfullife.com>, Ray Bryant <raybry@sgi.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: Bug in __pollwait() can cause select() and poll() to
 hang in 2.4.22-pre2 -- second try 
In-Reply-To: <20030701040105.2BCE42C22E@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0306302114170.2186-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Jul 2003, Rusty Russell wrote:
> 
> Linus?  See thread below: poll_wait is called with task state !=
> TASK_RUNNING, but can do a yield on low memory, causing eternal hangs.

Hint: 2.5.x does not have this problem, because the yield() in 2.5.x isn't
buggy.

So the proper fix is to just fix yield() on 2.4.x.

		Linus


