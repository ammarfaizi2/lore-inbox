Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWGGLAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWGGLAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWGGLAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:00:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14543 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932124AbWGGLAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:00:19 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <9736.1152269688@warthog.cambridge.redhat.com> 
References: <9736.1152269688@warthog.cambridge.redhat.com>  <20060706162731.577748e7.akpm@osdl.org> <20060706105223.97b9a531.akpm@osdl.org> <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com> <20060706124727.7098.44363.stgit@warthog.cambridge.redhat.com> <26133.1152211129@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, bernds_cb1@t-online.de,
       sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] FDPIC: Add coredump capability for the ELF-FDPIC binfmt [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 07 Jul 2006 12:00:13 +0100
Message-ID: <15239.1152270013@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> That doesn't compile... you're lacking file arguments.

Even more fun:

warthog>grep -r DUMP_WRITE include/
include/asm/elf.h:              DUMP_WRITE(&phdr, sizeof(phdr));                     \
include/asm/elf.h:                      DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,        \
include/asm-um/elf-i386.h:              DUMP_WRITE(&phdr, sizeof(phdr));             \
include/asm-um/elf-i386.h:                      DUMP_WRITE((void *) phdrp[i].p_vaddr,                 \
include/asm-ia64/elf.h:         DUMP_WRITE(&phdr, sizeof(phdr));               \
include/asm-ia64/elf.h:                 DUMP_WRITE((void *) gate_phdrs[i].p_vaddr,            \
include/asm-i386/elf.h:         DUMP_WRITE(&phdr, sizeof(phdr));                     \
include/asm-i386/elf.h:                 DUMP_WRITE((void *) vsyscall_phdrs[i].p_vaddr,        \


For another day, I think...

David
