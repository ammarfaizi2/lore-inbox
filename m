Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWCHTJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWCHTJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWCHTJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:09:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47581 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932448AbWCHTJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:09:08 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060308184500.GA17716@devserv.devel.redhat.com> 
References: <20060308184500.GA17716@devserv.devel.redhat.com>  <20060308173605.GB13063@devserv.devel.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com> <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <9834.1141837491@warthog.cambridge.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com> 
To: Alan Cox <alan@redhat.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 08 Mar 2006 19:08:42 +0000
Message-ID: <14275.1141844922@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> wrote:

> 	spin_lock(&foo->lock);
> 	writel(0, &foo->regnum);

I presume there only needs to be an mmiowb() here if you've got the
appropriate CPU's I/O memory window set up to be weakly ordered.

> 	writel(1, &foo->data);
> 	mmiowb();
> 	spin_unlock(&foo->lock);

David
