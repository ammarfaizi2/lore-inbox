Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWI3ERa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWI3ERa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 00:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWI3ERa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 00:17:30 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:65238 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750783AbWI3ERa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 00:17:30 -0400
Date: Sat, 30 Sep 2006 00:15:59 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ollie Wild <aaw@google.com>, dhollis@davehollis.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Jason Lunz <lunz@falooley.org>
Subject: Re: [uml-devel] [PATCH 2/2] UML - Don't roll my own random MAC generator
Message-ID: <20060930041559.GE10307@ccure.user-mode-linux.org>
References: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org> <65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com> <20060929153853.9bab3ca7.akpm@osdl.org> <65dd6fd50609291548x39707437yb7f1308c3397c488@mail.google.com> <20060929161616.7e47c453.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929161616.7e47c453.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 04:16:16PM -0700, Andrew Morton wrote:
> arch/um/os-Linux/sys-i386/registers.c: In function 'get_thread_regs':
> arch/um/os-Linux/sys-i386/registers.c:137: error: 'JB_PC' undeclared (first use in this function)
> arch/um/os-Linux/sys-i386/registers.c:137: error: (Each undeclared identifier is reported only once
> arch/um/os-Linux/sys-i386/registers.c:137: error: for each function it appears in.)
> arch/um/os-Linux/sys-i386/registers.c:138: error: 'JB_SP' undeclared (first use in this function)
> arch/um/os-Linux/sys-i386/registers.c:139: error: 'JB_BP' undeclared (first use in this function)

Hmmm, I never tried a cross-build before, but I don't even get this far:

  CC      arch/um/sys-i386/user-offsets.s
In file included from /usr/include/features.h:352,
                 from /usr/include/stdio.h:28,
                 from /home/jdike/linux/2.6/linux-2.6.17/arch/um/sys-i386/user-\offsets.c:1:
/usr/include/gnu/stubs.h:7:27: error: gnu/stubs-32.h: No such file or directory
m

I just flew into Ohio and am not in any shape to debug this atm.  I'll have
another look tomorrow.

				Jeff
