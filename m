Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267356AbTACAmG>; Thu, 2 Jan 2003 19:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267359AbTACAmG>; Thu, 2 Jan 2003 19:42:06 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:31950 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S267356AbTACAmF>;
	Thu, 2 Jan 2003 19:42:05 -0500
Date: Fri, 3 Jan 2003 01:50:33 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Christoph Hellwig <hch@infradead.org>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: __NR_exit_group for 2.4-O(1)
Message-ID: <20030103005033.GA3103@werewolf.able.es>
References: <20030103001522.GA1539@werewolf.able.es> <20030103003244.A10586@infradead.org> <20030103003617.GC1539@werewolf.able.es> <20030103004557.A10881@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030103004557.A10881@infradead.org>; from hch@infradead.org on Fri, Jan 03, 2003 at 01:45:57 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.03 Christoph Hellwig wrote:
> On Fri, Jan 03, 2003 at 01:36:17AM +0100, J.A. Magallon wrote:
> > > Your libc isn't the one from RH's new beta, is it? :)
> > > 
> > 
> > Nope, Mandrake Cooker glibc-2.3.1-6.
> 
> glibc only tries to use sys_exit_group if the kernel headers it's compiled
> against define __NR_exit_group.  AFAIK only the current RH beta ships
> a kernel with a 2.4 backport of all the threading changes during 2.5, so
> it might be worth asking the mdk glibc maintainer we he got his kernel
> headers from.. (either redhat or 2.5 :))
> 

It is defined in 2.4.20, undefined but reserved:

werewolf:/usr/src/linux-2.4.20> grep -r exit_group *
arch/x86_64/ia32/ia32entry.S:   .quad sys_ni_syscall    /* exit_group */
arch/i386/kernel/entry.S:       .long SYMBOL_NAME(sys_ni_syscall)       /* sys_exit_group */
include/asm-x86_64/ia32_unistd.h:#define __NR_ia32_exit_group           252
include/asm-i386/unistd.h:#define __NR_exit_group               252

???

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
