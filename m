Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbULOBAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbULOBAy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbULOA7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:59:47 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:16007
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261736AbULOAsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:48:38 -0500
Subject: Re: [PATCH] fix spurious OOM kills
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>,
       Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au,
       chris@tebibyte.org, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <20041215003707.GW16322@dualathlon.random>
References: <41A08765.7030402@ribosome.natur.cuni.cz>
	 <1101045469.23692.16.camel@thomas>
	 <1101120922.19380.17.camel@tglx.tec.linutronix.de>
	 <41A2E98E.7090109@ribosome.natur.cuni.cz>
	 <1101205649.3888.6.camel@tglx.tec.linutronix.de>
	 <41BF0F0D.4000408@ribosome.natur.cuni.cz>
	 <20041214173858.GJ16322@dualathlon.random>
	 <1103067018.5420.37.camel@npiggin-nld.site>
	 <20041214235549.GT16322@dualathlon.random>
	 <1103069783.3406.97.camel@tglx.tec.linutronix.de>
	 <20041215003707.GW16322@dualathlon.random>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 01:48:31 +0100
Message-Id: <1103071711.3406.106.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 01:37 +0100, Andrea Arcangeli wrote:
> On Wed, Dec 15, 2004 at 01:16:23AM +0100, Thomas Gleixner wrote:
> > It solves one of the problems, but your fix is really the only complete
> > fix I have in hands since this thread(s) started. + my simple changes to
> > the whom to kill selection :)
> 
> That patch prevents the machine to trigger "early" "suprious" oom kills
> (I had reports of suprious oom kills myself, oom killer triggered
> despite lots of swapcache was freeable), so it cannot help when a true
> oom happens like with your workload. In your workload the oom isn't
> a suprious error.

I know. In meantime I understood which patch solves which problem :)

tglx


