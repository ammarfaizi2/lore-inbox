Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUIEAS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUIEAS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 20:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUIEAS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 20:18:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:21129 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265029AbUIEASu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 20:18:50 -0400
Date: Sat, 4 Sep 2004 17:18:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
In-Reply-To: <20040904171417.67649169.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org>
References: <m3zn4bidlx.fsf@averell.firstfloor.org> <20040831183655.58d784a3.pj@sgi.com>
 <20040904133701.GE33964@muc.de> <20040904171417.67649169.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Sep 2004, Paul Jackson wrote:
> 
> How is what Linus left more broken?

It's not. If anything, we should probably remove even more.

I don't see what the problem was with just requiring the right damn size.  
User mode can trivially get the size by asking for it. But if it can't be
bothered, then Andi's code certainly just made things worse.

		Linus
