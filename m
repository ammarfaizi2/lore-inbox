Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292648AbSCILQR>; Sat, 9 Mar 2002 06:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292652AbSCILQG>; Sat, 9 Mar 2002 06:16:06 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:4868 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S292648AbSCILPy>;
	Sat, 9 Mar 2002 06:15:54 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15497.61055.615126.619184@argo.ozlabs.ibm.com>
Date: Sat, 9 Mar 2002 22:14:07 +1100 (EST)
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [bkpatch] do_mmap cleanup
In-Reply-To: <m2y9h2mqph.fsf@trasno.mitica>
In-Reply-To: <20020308185350.E12425@redhat.com>
	<m2y9h2mqph.fsf@trasno.mitica>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juan Quintela writes:

> Please, don't do that, export another function that does exactly that.
> sys_munmap is declared as asmlinkage, and some architectures (at
> least ppc used to have) need especial code to be able to call
> asmlinkage functions from inside the kernel.

Huh?  asmlinkage doesn't do anything on PPC, and never has.  It only
makes any difference on i386 and ia64 - see include/linux/linkage.h.

Paul.
