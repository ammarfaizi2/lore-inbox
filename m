Return-Path: <linux-kernel-owner+w=401wt.eu-S1161216AbXAHXO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbXAHXO6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161242AbXAHXO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:14:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:38009 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161216AbXAHXO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:14:57 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when check_timer fails.
Date: Tue, 9 Jan 2007 00:14:41 +0100
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Yinghai Lu <yinghai.lu@amd.com>, Linus Torvalds <torvalds@osdl.org>,
       mingo@redhat.com, Tobias Diedrich <ranma+kernel@tdiedrich.de>
References: <5986589C150B2F49A46483AC44C7BCA490733F@ssvlexmb2.amd.com> <m1k5zxgplv.fsf@ebiederm.dsl.xmission.com> <20070108223355.GI6167@stusta.de>
In-Reply-To: <20070108223355.GI6167@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701090014.42144.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We just got a completely different bug reported that was confirmed to be 
> caused by Andi's patch:
>    AMD64/ATI : timer is running twice as fast as it should [1]

I have such a machine that showed this problem and when I wrote the patch I 
tested it on it (and on a couple of others of course). No twice as fast on 
my testing.

In fact there are two types of ATI machines: ones that have a BIOS workaround
for the original Linux issue and ones that don't. Keeping both
happy is not easy.

So I'm somewhat dubious on that. Where is that report?

> 
> My whole point is that for 2.6.20, we can live with simply reverting 
> Andi's commit.

I agree. It's more problematical than I expected. Reverting is 
the best option right now.

-Andi
