Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbSK1CA6>; Wed, 27 Nov 2002 21:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbSK1CA6>; Wed, 27 Nov 2002 21:00:58 -0500
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:29422 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S265092AbSK1CAz>; Wed, 27 Nov 2002 21:00:55 -0500
Date: Wed, 27 Nov 2002 18:08:14 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Thomas Molina <tmolina@copper.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] README change
Message-ID: <20021128020814.GA10576@ip68-4-86-174.oc.oc.cox.net>
References: <1038443167.2063.28.camel@lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038443167.2063.28.camel@lap>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Hypocrisy alert: I'm feeling somewhat lazy right now so there could be
more grammar problems with this e-mail than with the file it's trying
to improve. OTOH this e-mail isn't distributed with every Linux kernel
source code tarball.]

On Wed, Nov 27, 2002 at 06:26:05PM -0600, Thomas Molina wrote:
> -   Do NOT use the /usr/src/linux area! This area has a (usually
> -   incomplete) set of kernel headers that are used by the library header
> -   files.  They should match the library, and not get messed up by
> -   whatever the kernel-du-jour happens to be.
> +   Do NOT use /usr/src/linux! This directory should contain the source 
> +   and headers of the kernel gcc was compile with.  They should match 
s/gcc/glibc/ (maybe better to just s+the /usr/src/linux area+/usr/src/linux+
and leave the rest of the paragraph unchanged)
> +   the compiler, and not get messed up by whatever the kernel-du-jour 
Again, s/compiler/library/ (i.e., undo your change, it was right the
first time)
> +   happens to be.

> -	- compiling the kernel with "Processor type" set higher than 386
> -	  will result in a kernel that does NOT work on a 386.  The
> -	  kernel will detect this on bootup, and give up.
> +	- compiling the kernel with an incorrect "Processor type" will 
> +          result in a kernel that does NOT work.  The kernel will detect 
> +          this on bootup, and give up.

Can the kernel still freeze during printk if it was compiled for the
wrong CPU type, or has that been fixed? (I haven't followed that closely
enough.)

>   - Make sure you have gcc 2.95.3 available.
>     gcc 2.91.66 (egcs-1.1.2), and gcc 2.7.2.3 are known to miscompile

Not a criticism of your patch, but something I just noticed now -- feel
free to ignore this: that comma after "(egcs-1.1.2)" seems awkward to me.

> - - In order to boot your new kernel, you'll need to copy the kernel
> + - In order to boot your new kernel you'll need to copy the kernel

Conversely, this is better with the comma (IMO).

>  IF SOMETHING GOES WRONG:
>  
> + - Please read the file REPORTING-BUGS before forwarding any reports
> +   of suspected kernel problems to maintainers or mailing lists.  It 
> +   contains a suggested format for bug reports as well as what
> +   information is most helpful to developers.

Something seems wrong to me about this sentence. The easiest potential
fix I can think of is s/contains/describes/, but that might not be a
100% fix. My problem with this sentence is that it seems to be saying
the file:
+ "contains a suggested format for bug reports"
+ "contains...what information is most helpful to developers"

I know what you mean by the latter, but if I interpret it in a slightly
more literal sense, it seems both semantically and syntactically flawed.

>   - If you have problems that seem to be due to kernel bugs, please check
>     the file MAINTAINERS to see if there is a particular person associated
>     with the part of the kernel that you are having trouble with. If there
>     isn't anyone listed there, then the second best thing is to mail
> -   them to me (torvalds@transmeta.com), and possibly to any other
> +   them to the linux-kernel mailing list and possibly to any other

Should this mention the mailing list's e-mail address?

>     relevant mailing-list or to the newsgroup.  The mailing-lists are
> -   useful especially for SCSI and networking problems, as I can't test
> -   either of those personally anyway. 
> +   useful especially for SCSI and networking problems

You (accidentally?) removed the period.

> -   sense).  If the problem is new, tell me so, and if the problem is
> -   old, please try to tell me when you first noticed it.
> +   sense).  If the problem is new, say so, and if the problem is
> +   old, please try to explain when you first noticed it.

Perhaps s/explain/tell us/ ?
