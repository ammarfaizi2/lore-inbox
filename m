Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315447AbSEQHID>; Fri, 17 May 2002 03:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSEQHIC>; Fri, 17 May 2002 03:08:02 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:9114 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315447AbSEQHH7>;
	Fri, 17 May 2002 03:07:59 -0400
Date: Fri, 17 May 2002 17:07:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal cleanups continued: cleanup do_signal
Message-Id: <20020517170716.723589b3.sfr@canb.auug.org.au>
In-Reply-To: <20020517165712.56950189.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002 16:57:12 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Linus,
> 
> 11 out of our 17 architectures have basically the same code
> in arch/../kernel/signal.c:do_signal.  This patch creates a
> common function for that bit of code and uses it in the places
> it can be.

Forgot to mention, that this code segment was originally extracted
by Paul Mackerras and original i386 patch was done by Anton Blanchard.

diffstat for those who are interested:

 arch/cris/kernel/signal.c     |  100 ++------------------------------------
 arch/i386/kernel/signal.c     |  106 +++-------------------------------------
 arch/mips/kernel/signal.c     |  101 +++-----------------------------------
 arch/mips64/kernel/signal.c   |  102 +++------------------------------------
 arch/mips64/kernel/signal32.c |  101 +++-----------------------------------
 arch/parisc/kernel/signal.c   |  107 +++--------------------------------------
 arch/ppc/kernel/signal.c      |  100 ++------------------------------------
 arch/ppc64/kernel/signal.c    |  108 ++---------------------------------------
 arch/ppc64/kernel/signal32.c  |  109 +++---------------------------------------
 arch/s390/kernel/signal.c     |  104 +++-------------------------------------
 arch/s390x/kernel/signal.c    |  103 ++-------------------------------------
 arch/s390x/kernel/signal32.c  |  101 +++-----------------------------------
 arch/sh/kernel/signal.c       |  101 +++-----------------------------------
 arch/x86_64/kernel/signal.c   |  107 +++--------------------------------------
 include/asm-alpha/signal.h    |    3 +
 include/asm-arm/signal.h      |    2 
 include/asm-ia64/signal.h     |    2 
 include/asm-m68k/signal.h     |    2 
 include/asm-sparc/signal.h    |    2 
 include/asm-sparc64/signal.h  |    3 +
 include/linux/signal.h        |    4 +
 kernel/signal.c               |  106 ++++++++++++++++++++++++++++++++++++++++
 22 files changed, 232 insertions(+), 1342 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
