Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266167AbUBQNXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 08:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUBQNXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 08:23:46 -0500
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:32947 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S266167AbUBQNXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 08:23:45 -0500
Date: Tue, 17 Feb 2004 08:23:34 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@azure.engin.umich.edu
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <Linux-MM@kvack.org>
Subject: Re: [PATCH] mremap NULL pointer dereference fix
In-Reply-To: <Pine.LNX.4.58.0402162203230.2154@home.osdl.org>
Message-ID: <Pine.SOL.4.44.0402170821070.13429-100000@azure.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> To trigger the bug you have to have _just_ the right memory usage, I
> suspect. You literally have to have the destination page directory
> allocation unmap the _exact_ source page (which has to be clean) for the
> bug to hit.
>

To trigger the bug, I have to run my test program in a "while true;"
loop for an hour or so.

> So I suspect the oops only triggers on the machine that the trigger
> program was written for.
>
> Your version of the patch saves a goto in the source, but results in an
> extra goto in the generated assembly unless the compiler is clever enough
> to notice the double test for NULL.
>
> Never mind, that's a micro-optimization, and your version is cleaner.
> Let's go with it if Rajesh can verify that it fixes the problem for him.

I will test the patch and report.

Thanks,
Rajesh


