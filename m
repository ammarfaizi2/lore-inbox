Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275755AbRI0EV6>; Thu, 27 Sep 2001 00:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275756AbRI0EVs>; Thu, 27 Sep 2001 00:21:48 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:23306 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S275755AbRI0EV3>;
	Thu, 27 Sep 2001 00:21:29 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15282.43290.653747.239332@cargo.ozlabs.ibm.com>
Date: Thu, 27 Sep 2001 14:20:42 +1000 (EST)
To: pjordan@whitehorse.blackwire.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 SMP on powermac3,3 7400. had to hack.
In-Reply-To: <20010926111115.A22056@panama>
In-Reply-To: <20010926111115.A22056@panama>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pjordan@whitehorse.blackwire.com writes:

> and for some funny reason, the arch/ppc/mm/init.c is the only one that does not have the lines 
> 
> #include <asm/tlb.h>
> 
> mmu_gather_t mmu_gathers[NR_CPUS];

Yes, somehow that got missed.

There is a patch that fixes this and other issues at
ftp://ftp.kernel.org/pub/linux/kernel/ports/ppc/ppc-patch-2.4.10.bz2

This patch has the differences between Linus' 2.4.10 and the
linuxppc_2_4 repository.  See http://penguinppc.org/dev/kernel.shtml
for details on how to access this and the other PPC repositories.

> Anyway, there is some funny video driver issue or something, I have to use prevent xdm from trying to start
> or this bugger will hang .. or at least I lose the video display and the monitor power light blinks on and off.

Sounds like an X config problem.  I suggest you ask on the
linuxppc-user@lists.linuxppc.org mailing list, you might get more help
there.

Paul.
