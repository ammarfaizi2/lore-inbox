Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTKHAG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTKGWMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:12:12 -0500
Received: from mx1.elte.hu ([157.181.1.137]:47234 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264410AbTKGPba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:31:30 -0500
Date: Fri, 7 Nov 2003 16:29:19 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Gross <mgross@linux.co.intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP signal latency fix up.
In-Reply-To: <Pine.LNX.4.44.0311070701370.1842-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.56.0311071627460.30352@earth>
References: <Pine.LNX.4.44.0311070701370.1842-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Nov 2003, Linus Torvalds wrote:

> The thing is, that simple patch does NOT solve the problem, [...]

doh, indeed. I was concentrating on the second patch but for a moment
thought that we could get away with a simpler patch, but nope, you are
right, we've got to touch both signal.c and sched.c, and there's no way
around the interface change.

	Ingo
