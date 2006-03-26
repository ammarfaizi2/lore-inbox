Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWCZFjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWCZFjm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 00:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWCZFjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 00:39:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750706AbWCZFjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 00:39:41 -0500
Date: Sat, 25 Mar 2006 21:35:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@osdl.org,
       arjan@infradead.org
Subject: Re: [patch 05/10] PI-futex: rt-mutex core
Message-Id: <20060325213551.3003c2f8.akpm@osdl.org>
In-Reply-To: <20060325184612.GF16724@elte.hu>
References: <20060325184612.GF16724@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> --- linux-pi-futex.mm.q.orig/init/Kconfig
>  +++ linux-pi-futex.mm.q/init/Kconfig
>  @@ -361,9 +361,14 @@ config BASE_FULL
>   	  kernel data structures. This saves memory on small machines,
>   	  but may reduce performance.
>   
>  +config RT_MUTEXES
>  +	boolean
>  +	select PLIST
>  +
>   config FUTEX
>   	bool "Enable futex support" if EMBEDDED
>   	default y
>  +	select RT_MUTEXES
>   	help

We can't turn these things off unless we also turn off futexes.  There goes
another 8.7 kbytes...
