Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQKKE6N>; Fri, 10 Nov 2000 23:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbQKKE6D>; Fri, 10 Nov 2000 23:58:03 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:519 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129450AbQKKE5v>;
	Fri, 10 Nov 2000 23:57:51 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Matt D. Robinson" <yakker@alacritech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI) 
In-Reply-To: Your message of "Fri, 10 Nov 2000 19:29:26 -0800."
             <3A0CBD16.5A07D189@alacritech.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 Nov 2000 15:57:45 +1100
Message-ID: <12004.973918665@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000 19:29:26 -0800, 
"Matt D. Robinson" <yakker@alacritech.com> wrote:
>We're removing lcrash from
>the kernel, putting it into its own RPM, and adding patches to the
>kernel for LKCD that build in crash dump functionality and make a new
>"Kernsyms" file so that we can dynamically read the symbol table of
>major parts of the kernel and give you memory dumps, stack traces,
>and even dump out entire structures dynamically.

kallsyms goes a long way towards solving the symbol table problem for
debugging.  It really only has three deficiencies, it does not detail
structure fields, it does not handle automatic variables and it does
not have source line numbers.  All of those need the sort of detail
provided by gcc -g, but the amount of data that generates is
prohibitively large, 40+ megabytes is a bit much to load into kernel
space.  I reluctantly decided that printing global addresses and
offsets was the best I could do, given the space constraints.

Instead of inventing your own kernsyms file, take a look at kallsyms.
It handles modules as well as the kernel.  Let me know if you want any
additional data in kallsyms.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
