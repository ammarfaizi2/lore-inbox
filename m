Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVLSON0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVLSON0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVLSON0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:13:26 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:12721 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750748AbVLSON0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:13:26 -0500
Subject: Re: [patch 10/15] Generic Mutex Subsystem,
	mutex-migration-helper-core.patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20051219013837.GF28038@elte.hu>
References: <20051219013837.GF28038@elte.hu>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 09:12:45 -0500
Message-Id: <1135001565.13138.247.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 02:38 +0100, Ingo Molnar wrote:
> +#ifdef CONFIG_DEBUG_MUTEX_FULL
> +# define semaphore             mutex_debug
> +# define DECLARE_MUTEX         DEFINE_MUTEX_DEBUG
> +#else
> +# define DECLARE_MUTEX         ARCH_DECLARE_MUTEX
> +#endif
> +
> +# define DECLARE_MUTEX_LOCKED  ARCH_DECLARE_MUTEX_LOCKED
> +
> +#if 0

Probably not good to have #if 0 in release patches.

-- Steve

> +#ifdef CONFIG_GENERIC_MUTEXES
> +# include <linux/mutex.h>
> +#else
> +
> +#define DECLARE_MUTEX          ARCH_DECLARE_MUTEX
> +#define DECLARE_MUTEX_LOCKED   ARCH_DECLARE_MUTEX_LOCKED
> +

