Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263042AbTCLFMY>; Wed, 12 Mar 2003 00:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263043AbTCLFMX>; Wed, 12 Mar 2003 00:12:23 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:37269 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S263042AbTCLFMW>;
	Wed, 12 Mar 2003 00:12:22 -0500
Date: Wed, 12 Mar 2003 16:22:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: schwidefsky@de.ibm.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
Message-Id: <20030312162251.0478d86e.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0303112055390.12728-100000@home.transmeta.com>
References: <20030312154413.40511744.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0303112055390.12728-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Mar 2003 21:02:09 -0800 (PST) Linus Torvalds <torvalds@transmeta.com> wrote:
>
> Why do you have to shout in the code with macro names from hell?

At least it is descriptive as opposed to an uncommented macro
called A ...

> Make the code _look_ good. Not look like SOMEBODY WHO CANNOT TYPE WITHOUT
> THE SHIFT KEY. Make the thing take properly typed arguments, instead of
> casting stuff two ways and backwards inside macros.

you mean like this?

static inline void *compat_ptr(compat_uptr_t uptr)
{
	return (void *)uptr;
}

and (for s390x)

static inline void *compat_ptr(compat_uptr_t uptr)
{
	return (void *)(uptr & 0x7fffffffUL);
}

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
