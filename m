Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTKQWnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 17:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTKQWnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 17:43:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:5358 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261755AbTKQWnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 17:43:16 -0500
Date: Mon, 17 Nov 2003 14:42:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <Pine.LNX.4.53.0311171639260.30079@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0311171441380.8840-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Nov 2003, Zwane Mwaikambo wrote:
> 
> I've managed to `fix` the triple fault (see further below for the patch 
> in all it's glory).

What's the generated assembly language for this function with and without 
the "fix"?

If adding that printk fixes a triple fault, the issue is not likely to be 
the printk itself as much as the difference in code that the compiler 
generates - stack frame, memory re-ordering etc...

		Linus

