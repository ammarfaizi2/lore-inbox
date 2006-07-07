Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWGGLNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWGGLNG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWGGLNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:13:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57758 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751000AbWGGLND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:13:03 -0400
Date: Fri, 7 Jul 2006 04:12:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, bernds_cb1@t-online.de,
       sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] FDPIC: Add coredump capability for the ELF-FDPIC
 binfmt [try #3]
Message-Id: <20060707041232.1ee6931c.akpm@osdl.org>
In-Reply-To: <15239.1152270013@warthog.cambridge.redhat.com>
References: <9736.1152269688@warthog.cambridge.redhat.com>
	<20060706162731.577748e7.akpm@osdl.org>
	<20060706105223.97b9a531.akpm@osdl.org>
	<20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com>
	<20060706124727.7098.44363.stgit@warthog.cambridge.redhat.com>
	<26133.1152211129@warthog.cambridge.redhat.com>
	<15239.1152270013@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul 2006 12:00:13 +0100
David Howells <dhowells@redhat.com> wrote:

> David Howells <dhowells@redhat.com> wrote:
> 
> > That doesn't compile... you're lacking file arguments.
> 
> Even more fun:
> 
> warthog>grep -r DUMP_WRITE include/
> include/asm/elf.h:              DUMP_WRITE(&phdr, sizeof(phdr));                     \
> include/asm/elf.h:                      DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,        \
> include/asm-um/elf-i386.h:              DUMP_WRITE(&phdr, sizeof(phdr));             \
> include/asm-um/elf-i386.h:                      DUMP_WRITE((void *) phdrp[i].p_vaddr,                 \
> include/asm-ia64/elf.h:         DUMP_WRITE(&phdr, sizeof(phdr));               \
> include/asm-ia64/elf.h:                 DUMP_WRITE((void *) gate_phdrs[i].p_vaddr,            \
> include/asm-i386/elf.h:         DUMP_WRITE(&phdr, sizeof(phdr));                     \
> include/asm-i386/elf.h:                 DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,        \
> 

all the world's an x86_64 ;)

Who inflicted this crap on us?  It looks like gcc code.

> For another day, I think...

Yeah.
