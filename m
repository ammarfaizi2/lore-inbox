Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWGEKo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWGEKo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 06:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWGEKo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 06:44:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932406AbWGEKo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 06:44:57 -0400
Date: Wed, 5 Jul 2006 03:44:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: mingo@elte.hu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-Id: <20060705034441.a123ca7a.akpm@osdl.org>
In-Reply-To: <20060705103756.GA5456@infradead.org>
References: <20060705084914.GA8798@elte.hu>
	<20060705023120.2b70add6.akpm@osdl.org>
	<20060705093259.GA11237@elte.hu>
	<20060705103756.GA5456@infradead.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 11:37:56 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jul 05, 2006 at 11:32:59AM +0200, Ingo Molnar wrote:
> > 
> > * Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > shrinks fs/select.o by eight bytes.  (More than I expected).  So it 
> > > does appear to be a space win, but a pretty slim one.
> > 
> > there are 855 calls to these functions in the allyesconfig vmlinux i 
> > did, and i measured a combined size reduction of 34791 bytes. That 
> > averages to a 40 bytes win per call site. (on i386.)
> 
> And more importantly it's a function that's called in slowpathes per
> definition.  So saving text sounds like a good idea, how minimal it
> may be.
> 

Well yes - as I said, it's a net win.  But 31 bytes per callsite seems
weird and makes one wonder what's going on.
