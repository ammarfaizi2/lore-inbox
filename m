Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263257AbTESWJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTESWJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:09:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28513 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S263257AbTESWJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:09:32 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>
	<Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
	<babhik$sbd$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 May 2003 16:18:39 -0600
In-Reply-To: <babhik$sbd$1@cesium.transmeta.com>
Message-ID: <m1d6ie37i8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
> By author:    Linus Torvalds <torvalds@transmeta.com>
> In newsgroup: linux.dev.kernel
> > 
> > A number of headers have historical baggage, mainly to support the 
> > old libc5 habits, and because removing the ifdef's is something that 
> > nobody has felt was worth the pain.
> > 
> > I think the only header file that should be considered truly exported is 
> > something like "asm/posix_types.h". For the others, we'll add __KERNEL__ 
> > protection on demand if the glibc guys can give good arguments that it 
> > helps them do the "copy-and-cleanup" phase.
> > 
> 
> Copy and cleanup isn't realistic either, though, because it doesn't
> track ABI changes.  

ABI changes or ABI additions?

If the ABI is not fixed that is a bug.  Admittedly some interfaces
in the development kernel are still under development and so have not
stabilized on an ABI but that is a different issue.

> ABI headers is the only realistic solution.  We
> can't realistically get real ABI headers for 2.5, so please don't just
> break things randomly until then.

As the ABI remains fixed I remain unconvinced.  Multiple implementations
against the same ABI should be possible.  The real question which is the
more scalable way to do the code.

What I find truly puzzling is that after years glibc still needs
kernel headers at all.

Eric
