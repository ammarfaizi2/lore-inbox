Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVDIAKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVDIAKx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 20:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVDIAKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 20:10:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:16552 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261211AbVDIAKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 20:10:33 -0400
Date: Fri, 8 Apr 2005 17:10:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: zwane@arm.linux.org.uk, mingo@redhat.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] silence spinlock/rwlock uninitialized break_lock member
 warnings
Message-Id: <20050408171026.5b822eeb.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0504090150520.2455@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504090150520.2455@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> Any chance this patch could be added to -mm (and possibly mainline)?

Spose I can stick it in -mm.

> It removes a bunch of warnings when building with gcc -W, like these:
> include/linux/wait.h:82: warning: missing initializer
> include/linux/wait.h:82: warning: (near initialization for `(anonymous).break_lock')
> include/asm/rwsem.h:88: warning: missing initializer
> include/asm/rwsem.h:88: warning: (near initialization for `(anonymous).break_lock')
> so there's less to sift through when looking for real problems with this 
> patch applied. 
> I've been using it for a while with no ill effects.

But I'd rather not add a bunch of even-more-ifdefs to support a compiler
flag which we're not going to use.  It's easy enough for the `gcc -W' user
to add the patch himself.


