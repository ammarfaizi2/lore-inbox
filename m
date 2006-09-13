Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWIMBSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWIMBSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWIMBSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:18:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50382 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751423AbWIMBSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:18:00 -0400
Date: Wed, 13 Sep 2006 02:17:59 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, linux-audit@redhat.com
Subject: Re: [git pull] audit updates and fixes
Message-ID: <20060913011759.GD29920@ftp.linux.org.uk>
References: <E1GMpjB-0002Ek-NP@ZenIV.linux.org.uk> <20060911180346.c4bfd211.akpm@osdl.org> <20060912071429.GB29920@ftp.linux.org.uk> <Pine.LNX.4.64.0609121737460.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609121737460.4388@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 05:39:08PM -0700, Linus Torvalds wrote:
> >  arch/i386/kernel/audit.c             |   51 ---------------------------
> >  b/arch/i386/kernel/Makefile          |    1
> >  b/arch/ia64/Kconfig                  |    4 ++
> >  b/arch/powerpc/Kconfig               |    4 ++
> >  b/arch/s390/Kconfig                  |    4 ++
> >  b/arch/sparc64/Kconfig               |    4 ++
> >  b/arch/sparc64/kernel/Makefile       |    3 +
> >  b/arch/sparc64/kernel/audit.c        |   66 +++++++++++++++++++++++++++++++++++
> >  b/arch/sparc64/kernel/compat_audit.c |   37 +++++++++++++++++++
> >  b/arch/x86_64/Kconfig                |    4 ++
> >  b/lib/Kconfig                        |    5 ++
> >  b/lib/Makefile                       |    1
> >  b/lib/audit.c                        |   53 ++++++++++++++++++++++++++++
> >  13 files changed, 185 insertions(+), 52 deletions(-)
> 
> Btw, if you do "git diff --stat --summary -M", you'd have gotten
> 
>  arch/i386/kernel/Makefile          |    1 -
>  arch/ia64/Kconfig                  |    4 ++
>  arch/powerpc/Kconfig               |    4 ++
>  arch/s390/Kconfig                  |    4 ++
>  arch/sparc64/Kconfig               |    4 ++
>  arch/sparc64/kernel/Makefile       |    3 ++
>  arch/sparc64/kernel/audit.c        |   66 ++++++++++++++++++++++++++++++++++++
>  arch/sparc64/kernel/compat_audit.c |   37 ++++++++++++++++++++
>  arch/x86_64/Kconfig                |    4 ++
>  lib/Kconfig                        |    5 +++
>  lib/Makefile                       |    1 +
>  {arch/i386/kernel => lib}/audit.c  |    2 +
>  12 files changed, 134 insertions(+), 1 deletions(-)
>  create mode 100644 arch/sparc64/kernel/audit.c
>  create mode 100644 arch/sparc64/kernel/compat_audit.c
>  rename arch/i386/kernel/audit.c => lib/audit.c (97%)
> 
> instead, which is much nicer. It shows the rename, and the summary info 
> also points out that some of the files were newly created.

I see...  FWIW, I'd been using git diff fed through diffstat(1) for that
part.  Thanks, that's indeed much better.

ObMIPS: how many ABI do we have there, anyway?  4 + IRIX compat?  More?
