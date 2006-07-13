Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWGMTGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWGMTGN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWGMTGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:06:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030290AbWGMTGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:06:10 -0400
Date: Thu, 13 Jul 2006 12:05:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Albert Cahalan <acahalan@gmail.com>,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
Subject: Re: utrace vs. ptrace
In-Reply-To: <200607131521.52505.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0607131203450.5623@g5.osdl.org>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com>
 <200607131437.28727.ak@suse.de> <20060713124316.GA18852@elte.hu>
 <200607131521.52505.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jul 2006, Andi Kleen wrote:

> 
> > > I'm not sure that's particularly useful (I think I would prefer to 
> > > keep it in kernel), [...]
> > 
> > why would we want to keep this in the kernel? Coredumping in the kernel 
> > is fragile, and it's nowhere near performance-critical to really live 
> > within the kernel.
> 
> Mostly because I fear it would become another udev like disaster, requiring user 
> space updates regularly, and core dumps are a fairly critical debugging feature
> that I wouldn't like to become unreliable.

Doing core-dumping in user space would be insane. It doesn't give _any_ 
advantages, only disadvantages.

Why do people keep thinking that doing things in user space is "safer" and 
"easier". It's quite often not. For example, all the "fragile" stuff would 
be true for a user-space dumper (don't tell me it's safer - it would 
obviously have to run with elevated capabilities), and a lot of it would 
be a hell of a lot harder.

		Linus
