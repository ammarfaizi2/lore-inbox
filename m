Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276963AbRJHPwq>; Mon, 8 Oct 2001 11:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276966AbRJHPwg>; Mon, 8 Oct 2001 11:52:36 -0400
Received: from ns.caldera.de ([212.34.180.1]:31405 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S276963AbRJHPw0>;
	Mon, 8 Oct 2001 11:52:26 -0400
Date: Mon, 8 Oct 2001 17:52:42 +0200
Message-Id: <200110081552.f98Fqgw22690@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: dmccr@us.ibm.com (Dave McCracken)
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Provide system call to get task id
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <71000000.1002555975@baldur>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <71000000.1002555975@baldur> you wrote:
> --- linux-2.4.10/arch/i386/kernel/entry.S	Sat Sep  8 14:02:32 2001
> +++ linux-2.4.10-gettid/arch/i386/kernel/entry.S	Mon Oct  8 09:57:39 2001
> @@ -619,6 +619,7 @@
>  	.long SYMBOL_NAME(sys_madvise)
>  	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
>  	.long SYMBOL_NAME(sys_fcntl64)
> +	.long SYMBOL_NAME(sys_gettid)
>  	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for TUX */

I think there was a reason why this syscall is marked reserved,
could you add it as Nr 224?  (223 is reserved in 2.4.11-pre as well).

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
