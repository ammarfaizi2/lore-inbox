Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbTACAr5>; Thu, 2 Jan 2003 19:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267366AbTACAr5>; Thu, 2 Jan 2003 19:47:57 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:39698 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267365AbTACAr4>; Thu, 2 Jan 2003 19:47:56 -0500
Date: Fri, 3 Jan 2003 00:56:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: libc-alpha@sources.redhat.com,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: __NR_exit_group for 2.4-O(1)
Message-ID: <20030103005624.A11159@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"J.A. Magallon" <jamagallon@able.es>, libc-alpha@sources.redhat.com,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030103001522.GA1539@werewolf.able.es> <20030103003244.A10586@infradead.org> <20030103003617.GC1539@werewolf.able.es> <20030103004557.A10881@infradead.org> <20030103005033.GA3103@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030103005033.GA3103@werewolf.able.es>; from jamagallon@able.es on Fri, Jan 03, 2003 at 01:50:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Context for libc-alpha:  current glibc CVS gets tons of -ENOSYS when
running on 2.4.  That's because it tries to use sys_exit_group if
__NR_exit_group is defined.

On Fri, Jan 03, 2003 at 01:50:33AM +0100, J.A. Magallon wrote:
> werewolf:/usr/src/linux-2.4.20> grep -r exit_group *
> arch/x86_64/ia32/ia32entry.S:   .quad sys_ni_syscall    /* exit_group */
> arch/i386/kernel/entry.S:       .long SYMBOL_NAME(sys_ni_syscall)       /* sys_exit_group */
> include/asm-x86_64/ia32_unistd.h:#define __NR_ia32_exit_group           252
> include/asm-i386/unistd.h:#define __NR_exit_group               252

Hmm.  It looks like glibc should test for something else than :)

