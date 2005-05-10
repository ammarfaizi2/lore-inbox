Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVEJFj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVEJFj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 01:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVEJFj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 01:39:28 -0400
Received: from web40907.mail.yahoo.com ([66.218.78.204]:19604 "HELO
	web40907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261470AbVEJFjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 01:39:20 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=GQ8LqaPEJ+Cf9H8Qy3aJ1/aAMFtiA0LZsF3KjDU+wGbN9JlzR0EtXl9RFGhvUdC4x6c+9b4oxdkVK7bhVZPpnMYxzvKgPXikUbaNVEl1hHLBsREwaS59gbbS1AaaHH+pt59SG0GhPLDJZs+hEeKN/tz8ng6cDsJCFZ8ixNoYvio=  ;
Message-ID: <20050510053914.77609.qmail@web40907.mail.yahoo.com>
Date: Mon, 9 May 2005 22:39:14 -0700 (PDT)
From: jensen galan <jrgalan@yahoo.com>
Subject: Re: Adding a system call to kernel
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Geert.

You know, I knew I had to do include this, and spent
all weekend trying to figure out where to include
<errno.h>.

But, for some reason, after reading your reply, the
simplicity dawned on me - include it in the user-space
program dummy.

That's what you should have written ;)

Thanks again - it worked!

Jensen

--- Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 9 May 2005, jensen galan wrote:
> > I am trying to add a system call to a 2.4 kernel. 
> > It's a simple system call which merely prints the
> > value of xtime.  The kernel recompiles OK, and my
> > user-space program (p5_a.c) actually works using
> the
> > added system call when I use syscall() and do not
> > generate a stub. (The 2 versions of my user-space
> > programs are included below).  However, when I try
> to
> > generate a stub in my user-space program using
> > _syscall2(), I receive the following compilation
> > error:
> > 
> > # gcc -Wall -D__KERNEL__ -I
> > /lib/modules/2.4.28-gentoo-r5/build/include -o
> p5_b
> > p5_b.c
> > /tmp/cc5nBrjZ.o(.text+0x23): In function
> > 'pedagogictime':
> > : undefined reference to 'errno'
> > collect2: ld returned 1 exit status
> 
> Please include <errno.h>
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond
> ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I
> call myself a hacker. But
> when I'm talking to journalists I just say
> "programmer" or something like that.
> 							    -- Linus Torvalds
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
