Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTKGWZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTKGWZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:25:40 -0500
Received: from mx1.elte.hu ([157.181.1.137]:47579 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264048AbTKGK32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 05:29:28 -0500
Date: Fri, 7 Nov 2003 11:24:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mark Gross <mgross@linux.co.intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] SMP signal latency fix up.
In-Reply-To: <1068158989.3555.43.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.56.0311071122360.21893@earth>
References: <1068158989.3555.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Nov 2003, Mark Gross wrote:

> Running on SMP and the 2.6.0-test9 kernel, it takes about 10000 * 1/HZ
> seconds.  Running this command with maxcpus=1 the command finishes in
> fraction of a second.  Under SMP the signal delivery isn't kicking the
> task if its in the run state on the other CPU.

yeah - good catch - it's a brown paper bag bug.

	Ingo
