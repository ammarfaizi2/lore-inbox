Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbUKNS0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbUKNS0p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 13:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUKNS0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 13:26:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:17570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261327AbUKNS0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 13:26:44 -0500
Date: Sun, 14 Nov 2004 18:26:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Manfred Spraul <manfred@colorfullife.com>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] __init in mm/slab.c
In-Reply-To: <20041114111551.GA8680@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0411141823460.2216@ppc970.osdl.org>
References: <E1CTDXF-0006mU-00@bkwatch.colorfullife.com> <419714B8.3030804@colorfullife.com>
 <20041114111551.GA8680@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Nov 2004, Andries Brouwer wrote:
>
> So yesterday's series of __init patches is not because there were
> bugs, but because it is desirable to have the situation where
> static inspection of the object code shows absence of references
> to .init stuff. Much better than having to reason that there is
> a reference but that it will not be used.

And I agree heartily with this. I love static checking (after all, that's 
all that sparse does), and if you can make sure that there is one less 
thing to be worried about, all the better.

Of course, another option to just removing/fixing the __init is to have 
some way to let the static checker know things are ok, but in this case, 
especially with fairly small data structures, it seems much easier to just 
make the checker happy.

		Linus
