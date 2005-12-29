Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVL2RLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVL2RLh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 12:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVL2RLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 12:11:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32205 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750890AbVL2RLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 12:11:37 -0500
Date: Thu, 29 Dec 2005 17:11:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch] updates XFS mutex patch
Message-ID: <20051229171135.GA21988@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Jes Sorensen <jes@trained-monkey.org>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <yq0zmmktbhk.fsf@jaguar.mkp.net> <20051229144824.GC18833@infradead.org> <20051229165811.GA23502@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229165811.GA23502@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 05:58:11PM +0100, Ingo Molnar wrote:
> 
> * Christoph Hellwig <hch@infradead.org> wrote:
> 
> > It's say just switch XFS to the one-arg mutex_init variant.
> > 
> > And ingo. please add the mutex_t typedef, analogue to spinlock_t it's 
> > a totally opaqueue to the users type, so it really should be a 
> > typedef.  After that the XFS mutex.h can just go away.
> 
> that's not possible, due to DEFINE_MUTEX() and due to struct mutex being 
> embedded in other structures. I dont think we want to lose that property 
> of struct semaphore, and only restrict mutex usage to pointers.

Sorry, but I don't get this sentence at all.  Can you try to rephrase it?
What does DEFINE_MUTEX have to do with declaring either a typedef or
structure?
