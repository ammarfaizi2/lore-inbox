Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314375AbSESMLx>; Sun, 19 May 2002 08:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314351AbSESMLw>; Sun, 19 May 2002 08:11:52 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:21216 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S314339AbSESMLw>;
	Sun, 19 May 2002 08:11:52 -0400
Date: Sun, 19 May 2002 22:10:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
Message-Id: <20020519221036.1289987a.sfr@canb.auug.org.au>
In-Reply-To: <E179P70-0003dg-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 May 2002 12:44:30 +0100 (BST) Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> > arch/ia64/kernel/signal.c:147:		return __copy_to_user(to, from, sizeof(siginfo_t));
> 
> Not a bug

Actually a bug as sys_ptrace on ia64 assumes that copy_siginfo_to_user
returns 0 or -Esomething.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
