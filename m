Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUGKKAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUGKKAU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUGKKAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:00:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:35790 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266543AbUGKKAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:00:15 -0400
Date: Sun, 11 Jul 2004 02:58:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com,
       linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-Id: <20040711025855.08afbca1.akpm@osdl.org>
In-Reply-To: <20040711095039.GA22391@elte.hu>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<20040711093209.GA17095@elte.hu>
	<20040711024518.7fd508e0.akpm@osdl.org>
	<20040711095039.GA22391@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > Ingo Molnar <mingo@elte.hu> wrote:
> > >
> > > For all the
> > >  other 200 might_sleep() points it doesnt matter much.
> > 
> > Sorry, but an additional 100 might_sleep()s is surely excessive for
> > debugging purposes, and unneeded for latency purposes: all these sites
> > are preemptible anyway.
> 
> nono, i mean the existing ones. (it's 116 not 200) There's no plan to
> add another 100, you've seen all the ones we found to be necessary for
> this.
> 

OK, but most of the new ones are unneeded with CONFIG_PREEMPT=y.  I'm still
failing to see why a non-preempt, voluntary preemption kernel even needs to
try to be competitive with a preemptible kernel?

