Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVLCMOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVLCMOy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 07:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVLCMOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 07:14:54 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:28039 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751181AbVLCMOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 07:14:54 -0500
Subject: Re: copy_from_user/copy_to_user question
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Al Viro <viro@ftp.linux.org.uk>,
       Vinay Venkataraghavan <raghavanvinay@yahoo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051203094314.GB8135@osiris.boeblingen.de.ibm.com>
References: <20051202224025.39396.qmail@web32108.mail.mud.yahoo.com>
	 <1133572199.32583.93.camel@localhost.localdomain>
	 <20051203013833.GG27946@ftp.linux.org.uk>
	 <1133575346.4894.7.camel@localhost.localdomain>
	 <20051203094314.GB8135@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 07:14:45 -0500
Message-Id: <1133612085.4894.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-03 at 10:43 +0100, Heiko Carstens wrote:
> > > > > Secondly, they seem to use memcpy as opposed to using
> > > > > copy_to_user/copy_from_user which is also very
> > > > > dangerous.
> > > > 
> > > > If they are grabbing data from user context into kernel (or vise versa)
> > > > that could easily cause an oops.  Not to mention it is a security risk.
> > > 
> > > Not to mention it simply won't work on a many platforms, no matter what...
> > 
> > Hmm, I've only worked with a few platforms (i386, x86_64, ppc, mips, and
> > a little arm but I don't remember that much).  I believe that a memcpy
> > could work on all these platforms (error prone of course, but if the
> > memory is mapped its OK).  When entering a system call, the kernel still
> > has access to the memory locations assigned to the user.
> 
> Won't work at all on platforms that have distinct address spaces for user
> and kernel space. E.g. on s390/s390x it wouldn't work. And yes, there are
> special instructions to copy data between address spaces.

Thanks for the update.  That's why I love working in an open
environment.  You learn something new every day ;)

-- Steve


