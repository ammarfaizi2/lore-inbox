Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755477AbWKQG6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbWKQG6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 01:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbWKQG6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 01:58:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45440 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1755477AbWKQG6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 01:58:31 -0500
Date: Fri, 17 Nov 2006 06:58:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Yitzchak Eidus <ieidus@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: changing internal kernel system mechanism in runtime by a module patch
Message-ID: <20061117065828.GA25155@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Muli Ben-Yehuda <muli@il.ibm.com>,
	Yitzchak Eidus <ieidus@gmail.com>, linux-kernel@vger.kernel.org
References: <e7aeb7c60611161119h3e198e96va07d36d5b2dd6390@mail.gmail.com> <20061117064732.GC3735@rhun.zurich.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117064732.GC3735@rhun.zurich.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 08:47:32AM +0200, Muli Ben-Yehuda wrote:
> > i am talking about a clean/standard way to do such thing
> > (without overwrite the mem address of the function and replace it in a
> > dirty way...)
> 
> k42 supports "dynamic hot-swap" and there's been some work done to
> bring it into Linux, see e.g.,
> http://ozlabs.org/pipermail/k42-discussion/2006-October/001615.html.

This kind of stuff is just sick.  Better let them play with their research
OS for this kind of thing :)  In practice any non-trivial bug fix requires
changes to global data structures so reloading a module doesn't make sense.
And for module-specific problems you should be able to hack around using
kprobes if you really need (but then again for a mission critical system
you should have proper active-active failover clustering anyway)
