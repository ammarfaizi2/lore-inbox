Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWGMMh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWGMMh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWGMMh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:37:26 -0400
Received: from ns2.suse.de ([195.135.220.15]:46787 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750884AbWGMMh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:37:26 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: utrace vs. ptrace
Date: Thu, 13 Jul 2006 14:37:28 +0200
User-Agent: KMail/1.9.1
Cc: Albert Cahalan <acahalan@gmail.com>, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com> <20060713070445.GA30842@elte.hu> <20060713092432.GA11812@elte.hu>
In-Reply-To: <20060713092432.GA11812@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607131437.28727.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 July 2006 11:24, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> > utrace enables something like 'transparent live debugging': an app
> > crashes in your distro, a window pops up, and you can 'hand over' a
> > debugging session to a developer you trust. Or you can instruct the
> > system to generate a coredump. Or you can generate a shorter summary
> > of the crash, sent to a central site.
>
> not to mention that utrace could be used to move most of the ELF
> coredumping code out of the kernel. (the moment you have access to all
> crashed threads userspace can construct its own coredump - instead of
> having the kernel construct a coredump file) Roland's patch does not go
> as far yet, but it could be a possible target.

I'm not sure that's particularly useful (I think I would prefer to keep
it in kernel), but executing a program when a core dump happens is useful with 
lots of applications.  I had patches for this
that i should probably submit at some point.


-Andi

> 	Ingo
