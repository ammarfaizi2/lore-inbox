Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVLCCCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVLCCCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 21:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVLCCCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 21:02:46 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:15094 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751150AbVLCCCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 21:02:46 -0500
Subject: Re: copy_from_user/copy_to_user question
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Vinay Venkataraghavan <raghavanvinay@yahoo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051203013833.GG27946@ftp.linux.org.uk>
References: <20051202224025.39396.qmail@web32108.mail.mud.yahoo.com>
	 <1133572199.32583.93.camel@localhost.localdomain>
	 <20051203013833.GG27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 21:02:26 -0500
Message-Id: <1133575346.4894.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-03 at 01:38 +0000, Al Viro wrote:
> On Fri, Dec 02, 2005 at 08:09:59PM -0500, Steven Rostedt wrote:
> > > Secondly, they seem to use memcpy as opposed to using
> > > copy_to_user/copy_from_user which is also very
> > > dangerous.
> > 
> > If they are grabbing data from user context into kernel (or vise versa)
> > that could easily cause an oops.  Not to mention it is a security risk.
> 
> Not to mention it simply won't work on a many platforms, no matter what...

Hmm, I've only worked with a few platforms (i386, x86_64, ppc, mips, and
a little arm but I don't remember that much).  I believe that a memcpy
could work on all these platforms (error prone of course, but if the
memory is mapped its OK).  When entering a system call, the kernel still
has access to the memory locations assigned to the user.

It's been a while since I had to deal with the semantics of
copy_to/from_user.  So what platforms can not access a user space area
directly.  Is there a special assembly command to use to copy from user?

I haven't dealt (yet) with the copy_user of x86_64.  Is there a problem
when one tries to copy to/from a 32 bit address while in a 64 bit
address space?

Just curious, sorry for my ignorance here.

-- Steve
 

