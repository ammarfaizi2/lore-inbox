Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276075AbRJYUOs>; Thu, 25 Oct 2001 16:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276099AbRJYUOi>; Thu, 25 Oct 2001 16:14:38 -0400
Received: from ns.caldera.de ([212.34.180.1]:38604 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S276075AbRJYUOb>;
	Thu, 25 Oct 2001 16:14:31 -0400
Date: Thu, 25 Oct 2001 22:14:51 +0200
Message-Id: <200110252014.f9PKEpI22226@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: offer@sgi.com (richard offer)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export syscalls
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <100000000.1004038404@changeling.engr.sgi.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <100000000.1004038404@changeling.engr.sgi.com> you wrote:
> * frm hch@caldera.de "10/25/2001 05:25:40 PM +0000" | sed '1,$s/^/* /'
> *
> * Hi Linus,
> * 
> * the appended patch exports the syscalls (GPL-limited), this is needed
> * for the Linux-ABI modules so they can use the syscalls in their
> * syscall tables for non-Linux personalities.
>
>
> What is the rationale for marking these as GPL-exclusive symbols ? 
>
> I thought system calls were a public interface.

That won't change, but the syscalls are exported GPL-only for _inkernel_
users.  My first version of the patch didn't do that, but people think
that they can cause to much pain when used incorrectly, and that is
checkable only with non-binary-only modules.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
