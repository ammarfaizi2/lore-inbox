Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314694AbSEFUL4>; Mon, 6 May 2002 16:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314709AbSEFULz>; Mon, 6 May 2002 16:11:55 -0400
Received: from [195.39.17.254] ([195.39.17.254]:41108 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314694AbSEFULy>;
	Mon, 6 May 2002 16:11:54 -0400
Date: Sat, 27 Apr 2002 04:53:15 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.12] x86 Boot enhancements,  32bit entries 6/11
Message-ID: <20020427045314.A597@toy.ucw.cz>
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org> <m1wuumy5eo.fsf@frodo.biederman.org> <m1sn5ay5ac.fsf_-_@frodo.biederman.org> <m1offyy55x.fsf_-_@frodo.biederman.org> <m1it66y4xz.fsf_-_@frodo.biederman.org> <m1elguy4pj.fsf_-_@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch cleans up the 32bit kernel entry points so they don't
> assume who their caller is, making them usable by other than setup.S
> 
> For arch/i386/kernel/head.S this untangles the secondary cpu and the bootstrap
> entry points making the code more readable.

Hmm, but making variables called eax, ebx, ... is surely going to confuse
someone. What about bootup_eax, .. ?

> +	/*
> +	 * Save the initial registers
> +	 */
> +	movl %eax, eax
> +	movl %ebx, ebx
> +	movl %ecx, ecx
> +	movl %edx, edx
> +	movl %esi, esi
> +	movl %edi, edi
> +	movl %esp, esp
> +	movl %ebp, ebp
> +
> +	/*
> +	 * Setup the stack
> +	 */
> +	movl stack_start, %esp
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

