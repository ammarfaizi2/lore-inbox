Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757177AbWKVXmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757177AbWKVXmW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757178AbWKVXmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:42:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35307 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757177AbWKVXmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:42:21 -0500
Date: Wed, 22 Nov 2006 15:41:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: eric.valette@free.fr
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: FYI build failure : 2.6.19-rc6-git5 unresolved
 spin_lock_irqsave_nested
Message-Id: <20061122154125.babd0cec.akpm@osdl.org>
In-Reply-To: <4564C34C.7050000@free.fr>
References: <4564C34C.7050000@free.fr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 22:38:20 +0100
Eric Valette <eric.valette@free.fr> wrote:

> net/built-in.o: dans la fonction __ irlmp_slsap_inuse __:
> irlmp.c:(.text+0x6ea89): r__f__rence ind__finie vers __
> spin_lock_irqsave_nested __
> make[1]: *** [.tmp_vmlinux1] Erreur 1
> make: *** [bzImage] Erreur 2

Linus merged a lockdep fixup patch which was dependent upon infrastructure
which is only in -mm.

I'll send lockdep-spin_lock_irqsave_nested.patch (and its two fixes) (and
enforce-unsigned-long-flags-when-spinlocking.patch which precedes it) along
to Linus in the next batch, so this will come right.

