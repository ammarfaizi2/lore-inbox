Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbSLHJmh>; Sun, 8 Dec 2002 04:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSLHJmh>; Sun, 8 Dec 2002 04:42:37 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:21742 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S265255AbSLHJmg>; Sun, 8 Dec 2002 04:42:36 -0500
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 20
From: Arjan van de Ven <arjanv@redhat.com>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3DF2F8D9.6CA4DC85@mvista.com>
References: <3DF2F8D9.6CA4DC85@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 10:50:09 +0100
Message-Id: <1039341009.1483.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 08:46, george anzinger wrote:

> +/*
> + * Here is an SMP helping macro...
> + */
> +#ifdef CONFIG_SMP
> +#define IF_SMP(a) a
> +#else
> +#define IF_SMP(a)
> +#endif


ehmmmmm personally I would consider any need of this ugly and evil

> +	IF_SMP(if (old_base && (new_base != old_base))
> +	       spin_unlock(&old_base->lock);
> +		)

Like here..... SMP dependent ifdef's of spinlock usage... shudder



