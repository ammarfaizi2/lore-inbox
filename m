Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <155238-18252>; Thu, 19 Nov 1998 16:55:47 -0500
Received: from neon-best.transmeta.com ([206.184.214.10]:4321 "EHLO neon.transmeta.com" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <155279-18252>; Thu, 19 Nov 1998 12:12:25 -0500
Date: Thu, 19 Nov 1998 10:08:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@e-mind.com>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: entry.S mess with %ebx (&current pointer)
In-Reply-To: <Pine.LNX.3.95.981119095352.2684C-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.95.981119100721.2684D-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Thu, 19 Nov 1998, Linus Torvalds wrote:
> 
> This patch should fix it properly, please tell me whether that is true..

Duh, the ".globl" declaration should also obviously be fixed to be
ret_from_fork rather than ret_from_smpfork in order for this to link..

		Linus

-----
> diff -u --recursive --new-file v2.1.129/linux/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
> --- v2.1.129/linux/arch/i386/kernel/entry.S	Sun Nov  8 14:02:42 1998
> +++ linux/arch/i386/kernel/entry.S	Thu Nov 19 09:53:08 1998
> @@ -150,14 +150,14 @@
>  	jmp ret_from_sys_call
>  
>  
> -#ifdef __SMP__
>  	ALIGN
>  	.globl	ret_from_smpfork
		^^^^^^^^^^^^^^^^


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
