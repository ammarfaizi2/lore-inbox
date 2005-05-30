Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVE3NZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVE3NZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 09:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVE3NZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 09:25:42 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:53512 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261539AbVE3NZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 09:25:25 -0400
Date: Mon, 30 May 2005 06:30:07 -0700
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>, Takashi Iwai <tiwai@suse.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: what is the -RT tree
Message-ID: <20050530133007.GA8641@nietzsche.lynx.com>
References: <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu> <20050527133122.GF86087@muc.de> <s5hwtpkwz4z.wl@alsa2.suse.de> <20050530095349.GK86087@muc.de> <20050530103347.GA13425@elte.hu> <20050530105618.GL86087@muc.de> <20050530121031.GA26255@elte.hu> <20050530124038.GM86087@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530124038.GM86087@muc.de>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 02:40:38PM +0200, Andi Kleen wrote:
...
> Ok where are the big issues left? 

Pretty much the entire kernel and anything that has a loop in it.
That's why the use of preemption points can't work in that it
can't be spread throughout the kernel in the way you've mentioned.
 
> Yes, I understand that. But because of that it is not really
> fair to compare the standard kernel to RT tree with all bells and whistles
> enabled. I think it would be much better if RT was considered
> as individual pieces, not all or nothing.

The lock work is an all or nothing chunk. It's the main portion
of this patch that gives the major performance boost. All other
work is marginal at best to support latency or instrumentation
to back it. No insult, but Ingo's has said this multipule times.

bill

