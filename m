Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422692AbWCWUvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422692AbWCWUvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422693AbWCWUvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:51:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50643 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422692AbWCWUvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:51:23 -0500
Date: Thu, 23 Mar 2006 12:49:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       iwamoto@valinux.co.jp, christoph@lameter.com, wfg@mail.ustc.edu.cn,
       npiggin@suse.de, riel@redhat.com
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
In-Reply-To: <20060323223057.GA12895@dmt.cnet>
Message-ID: <Pine.LNX.4.64.0603231243160.26286@g5.osdl.org>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
 <20060322145132.0886f742.akpm@osdl.org> <20060323205324.GA11676@dmt.cnet>
 <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org> <20060323223057.GA12895@dmt.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Mar 2006, Marcelo Tosatti wrote:
> 
> Nope, LRU only beat CLOCK-Pro/CART on the "UMass trace" (which is trace
> replay, which can be very sensitive and not necessarily meaningful).
> Needs more study though (talk is cheap).

Umm.. That _trace_ was the only thing that seemed to have any real-life 
dataset, afaik. The others were totally synthetic.

> Anyway, smarter algorithms such as this two have been proven to be more
> efficient than LRU under a large range of real life loads. LRU's lack of
> frequency information is really terrible.
> 
> LRU's worst case scenarios were well known before I was born.

The kernel doesn't actually use LRU, so the fact that LRU isn't good seems 
a non-argument.

> - "Every time I wake up in the morning updatedb has thrown my applications
> out of memory".
> 
> - "Linux is awful every time I untar something larger than memory to disk".

People seem to think that the fact that there are bad behaviours means 
that there are somehow "magic" algorithms that don't have bad behaviours.

I'd really suggest somebody show better real-life numbers with a new 
algorithm _before_ we do anything like this.

			Linus
