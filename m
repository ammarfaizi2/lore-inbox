Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422718AbWJXWrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWJXWrm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422764AbWJXWrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:47:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3495 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422718AbWJXWrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:47:42 -0400
Date: Tue, 24 Oct 2006 23:47:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Message-ID: <20061024224731.GA31091@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	LKML <linux-kernel@vger.kernel.org>
References: <1161576857.3466.9.camel@nigel.suspend2.net> <20061024204239.GA15689@infradead.org> <1161727596.22729.11.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161727596.22729.11.camel@nigel.suspend2.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 08:06:36AM +1000, Nigel Cunningham wrote:
> IIRC, I avoided list.h because I only wanted a singly linked list (it
> never gets traversed backwards). List.h looks to me like all doubly
> linked lists. Do you know if there are any other singly linked list
> implementations I could piggy-back?
> 
> That said, since there's normally not that many extents, I could switch
> quite easily and it wouldn't normally waste much memory.

If the overhead doesn't matter for you (and I doubt it does) I'd say just
use list.h.    Reusing existing code that doesn't need to be debugged and
is idiomatically readable to everyone is very helpfull.

