Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbVLQD6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbVLQD6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 22:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVLQD6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 22:58:52 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:61366 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751365AbVLQD6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 22:58:52 -0500
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
From: Steven Rostedt <rostedt@goodmis.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
       akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com>
	 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 22:58:34 -0500
Message-Id: <1134791914.13138.167.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 23:13 +0000, David Howells wrote:
> The attached patch introduces a simple mutex implementation as an alternative
> to the usual semaphore implementation where simple mutex functionality is all
> that is required.
> 
> This is useful in two ways:
> 
>  (1) A number of archs only provide very simple atomic instructions (such as
>      XCHG on i386, TAS on M68K, SWAP on FRV) which aren't sufficient to
>      implement full semaphore support directly. Instead spinlocks must be
>      employed to implement fuller functionality.
> 
>  (2) This makes it more obvious that a mutex is a mutex and restricts the
>      capabilites to make it more easier to debug.
> 
> This patch set does the following:
> 
>  (1) Renames DECLARE_MUTEX and DECLARE_MUTEX_LOCKED to be DECLARE_SEM_MUTEX and
>      DECLARE_SEM_MUTEX_LOCKED for counting semaphores.
> 

Could we really get rid of that "MUTEX" part.  A counting semaphore is
_not_ a mutex, although a mutex _is_ a counting semaphore.  As is a Jack
Russell is a dog, but a dog is not a Jack Russell.

What's the reason not to just use DECLARE_SEM and DECLARE_SEM_LOCKED?

-- Steve


