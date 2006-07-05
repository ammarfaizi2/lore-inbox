Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWGEKiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWGEKiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 06:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWGEKiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 06:38:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53174 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964794AbWGEKh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 06:37:59 -0400
Date: Wed, 5 Jul 2006 11:37:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-ID: <20060705103756.GA5456@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	arjan@infradead.org
References: <20060705084914.GA8798@elte.hu> <20060705023120.2b70add6.akpm@osdl.org> <20060705093259.GA11237@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705093259.GA11237@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 11:32:59AM +0200, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > shrinks fs/select.o by eight bytes.  (More than I expected).  So it 
> > does appear to be a space win, but a pretty slim one.
> 
> there are 855 calls to these functions in the allyesconfig vmlinux i 
> did, and i measured a combined size reduction of 34791 bytes. That 
> averages to a 40 bytes win per call site. (on i386.)

And more importantly it's a function that's called in slowpathes per
definition.  So saving text sounds like a good idea, how minimal it
may be.

> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---end quoted text---
