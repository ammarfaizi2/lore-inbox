Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTKRRXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 12:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTKRRXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 12:23:32 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:38019
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263763AbTKRRXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 12:23:31 -0500
Date: Tue, 18 Nov 2003 12:22:15 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <149480000.1069177112@flay>
Message-ID: <Pine.LNX.4.53.0311181219490.11537@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0311180830050.18739-100000@home.osdl.org>
 <Pine.LNX.4.53.0311181149310.11537@montezuma.fsmlabs.com> <149480000.1069177112@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003, Martin J. Bligh wrote:

> The other thing I've found printks to hide before is timing bugs / races.
> Unfortunately I can't see one here, but maybe someone else can ;-)
> Maybe inserting a 1ms delay or something in place of the printk would
> have the same effect?

I've tried a number of timing related workarounds, namely;
schedule_timeout(2*HZ) and some long spinning loops. I've also thrown a 
schedule() in there at some point.
