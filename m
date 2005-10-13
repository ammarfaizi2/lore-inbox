Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVJMIwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVJMIwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 04:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVJMIwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 04:52:16 -0400
Received: from mail.gmx.net ([213.165.64.21]:55461 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932254AbVJMIwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 04:52:15 -0400
Date: Thu, 13 Oct 2005 10:52:13 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       Andries.Brouwer@cwi.nl
MIME-Version: 1.0
References: <200510121010.16274.jbarnes@virtuousgeek.org>
Subject: Re: man-pages-2.08 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <20785.1129193533@www73.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: Jesse Barnes <jbarnes@virtuousgeek.org>
> 
> On Wednesday, October 12, 2005 9:26 am, Michael Kerrisk wrote:
> > This is a request to kernel developers: if you make a change
> > to a kernel-userland interface, or observe a discrepancy
> > between the manual pages and reality, would you please send
> > me (at mtk-manpages@gmx.net ) one of the following
> > (in decreasing order of preference):
> 
> Would it make sense for some of the man pages (or maybe all of them) that 
> correspond directly to kernel interfaces (e.g. syscalls, procfs & sysfs 
> descriptions) to be bundled directly with the kernel?  Andrew is 
> generally pretty good about asking people to update the stuff in 
> Documentation/ when necessary, so maybe the man pages would be kept more 
> up to date if developers were forced to deal with them more directly.

Recently, I was just wondering the same thing.  However, there 
are complexities to consider.  C libraries (okay, glibc is the 
main one I concern myself with) sometimes add some functionality 
in the wrapper function for a particular system call.  This also
needs to be documented in the Secion 2 page. 

Nevertheless, I think the idea of binding the kernel sources and 
Sections 2 and 4 of the manual pages a bit more tightly bears
some consideration.  In the ideal world, when a change is made to
the kernel, the patch could include adjustments to the man 
pages (if relevant) -- then the changes could follow the patch 
through the -mm tree and then into Linus's tree.

> OTOH, they comprise a fairly large package, so adding them to the kernel 
> tarball would increase its size a lot.

I'd guess that the uncompressed source of the relevant pages 
would be around 3 MB.
 
> The man pages are great; 

Thanks.  But the greatest part of credit must go to Andries, 
the maintainer for nearly 10 years.  I'm shortly coming up to my 
first anniversary...

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  Grab the latest
tarball at ftp://ftp.win.tue.nl/pub/linux-local/manpages/
and grep the source files for 'FIXME'.
