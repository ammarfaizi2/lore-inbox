Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWHQMUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWHQMUF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWHQMUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:20:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:57492 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932107AbWHQMUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:20:01 -0400
Date: Thu, 17 Aug 2006 05:14:49 -0700
From: Greg KH <greg@kroah.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 2/7] UBC: core (structures, API)
Message-ID: <20060817121449.GA17649@kroah.com>
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru> <20060816171527.GB27898@kroah.com> <44E456F4.10001@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E456F4.10001@sw.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 03:45:56PM +0400, Kirill Korotaev wrote:
> >>+struct user_beancounter
> >>+{
> >>+	atomic_t		ub_refcount;
> >
> >
> >Why not use a struct kref here instead of rolling your own reference
> >counting logic?
> 
> We need more complex decrement/locking scheme than krefs
> provide. e.g. in __put_beancounter() we need
> atomic_dec_and_lock_irqsave() semantics for performance optimizations.

Ah, ok, missed that.  Nevermind then :)

thanks,

greg k-h
