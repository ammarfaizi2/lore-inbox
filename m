Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbREUA7I>; Sun, 20 May 2001 20:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbREUA6t>; Sun, 20 May 2001 20:58:49 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:18444 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262288AbREUA6r>;
	Sun, 20 May 2001 20:58:47 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: const __init 
In-Reply-To: Your message of "Sun, 20 May 2001 22:16:11 +0200."
             <01052022161101.02140@enzo.bigblue.local> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 May 2001 10:58:39 +1000
Message-ID: <9209.990406719@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001 22:16:11 +0200, 
Franz Sirl <Franz.Sirl-kernel@lauterbach.com> wrote:
>Yes, and gcc3 errors on these constructs,  cause it cannot decide if the data 
>should be put into a .data or .rodata section.
>Dunno if it's worth to create a __initconstdata/__initrodata though, but it 
>would be easy implement I guess.

Not worth it.  Adding finer grained init.data sections requires changes
to every architecture's vmlinux.lds script but it gains you nothing,
the sections are discarded after the kernel has booted.

