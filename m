Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265213AbUF1VEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUF1VEg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbUF1VEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:04:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15580 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265215AbUF1VCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:02:10 -0400
Date: Mon, 28 Jun 2004 14:01:57 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: "David S. Miller" <davem@redhat.com>, Scott Wood <scott@timesys.com>,
       oliver@neukum.org, greg@kroah.com, arjanv@redhat.com,
       jgarzik@redhat.com, tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, david-b@pacbell.net, zaitcev@redhat.com
Subject: Re: drivers/block/ub.c
Message-Id: <20040628140157.5813bc73@lembas.zaitcev.lan>
In-Reply-To: <20040628205058.GB8502@one-eyed-alien.net>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<200406270631.41102.oliver@neukum.org>
	<20040626233423.7d4c1189.davem@redhat.com>
	<200406271242.22490.oliver@neukum.org>
	<20040627142628.34b60c82.davem@redhat.com>
	<20040628141517.GA4311@yoda.timesys>
	<20040628132531.036281b0.davem@redhat.com>
	<20040628205058.GB8502@one-eyed-alien.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004 13:50:58 -0700
Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:

> > 	struct txd {
> > 		u32 dma_addr;
> > 		u32 length;
> > 	};
> > 
> > It is just total and utter madness to put a packed or the proposed
> > __nopadding__ attribute on that structure.  Yet this seems to be
> > what was suggested now and at the beginning of this thread.
> 
> I guess, in the end, what this comes down to is the fact that we're all
> going to get bitten on the ass when we finally get to a platform where the
> default alignment is 64-bits, which would then (by default) add padding to
> the above structure.
> 
> How long until that time comes?  Likely within my lifetime, and I'd rather
> not have to re-write working code into more working code because I couldn't
> express to the compiler what I needed it to do.

I, for one, am not engaging into such flights of fancy as a platform
with larger than natural alignment requirements. Would you even read
what you're writing? The whole freaking world abandons silly platforms
and moves to x86 extensions and you're fantasizing about a return
to Cray-1. It just ain't happening!

My ass is completely at ease about being bitten by your imaginary monsters.

-- Pete
