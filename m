Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWJJDQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWJJDQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWJJDPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:15:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964927AbWJJDOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:14:49 -0400
Date: Mon, 9 Oct 2006 20:14:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-Id: <20061009201418.81bf0acd.akpm@osdl.org>
In-Reply-To: <20061009143345.GB17572@in.ibm.com>
References: <20061004214403.e7d9f23b.akpm@osdl.org>
	<m1ejtnb893.fsf@ebiederm.dsl.xmission.com>
	<20061004233137.97451b73.akpm@osdl.org>
	<m14pui4w7t.fsf@ebiederm.dsl.xmission.com>
	<20061005235909.75178c09.akpm@osdl.org>
	<m1bqop38nw.fsf@ebiederm.dsl.xmission.com>
	<20061006183846.GF19756@in.ibm.com>
	<4526A66B.4030805@zytor.com>
	<m1ac49z2fl.fsf@ebiederm.dsl.xmission.com>
	<4526D084.1030700@zytor.com>
	<20061009143345.GB17572@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 10:33:45 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> Please find attached the regenerated patch.

Somewhere amongst the six versions of this patch, the kernel broke.  Seems
that the kernel command line isn't getting recognised.  The machine is
running LILO and RH FC1.

I'll consolidate the patches which I have now and then I'll drop them.

They are (were), in order:

i386-distinguish-absolute-symbols.patch
i386-distinguish-absolute-symbols-fix.patch
i386-align-data-section-to-4k-boundary.patch
i386-define-__pa_symbol-2.patch
i386-setupc-reserve-kernel-memory-starting-from-_text.patch
i386-config_physical_start-cleanup.patch
make-linux-elfh-safe-to-be-included-in-assembly-files.patch
elf-add-elfosabi_standalone-to-elfh.patch
kallsyms-generate-relocatable-symbols.patch
i386-relocatable-kernel-support.patch
i386-implement-config_physical_align.patch
i386-boot-add-an-elf-header-to-bzimage.patch
i386-boot-add-an-elf-header-to-bzimage-fix.patch
i386-boot-add-an-elf-header-to-bzimage-update-2.patch
i386-boot-add-an-elf-header-to-bzimage-fix-fix.patch
i386-boot-add-an-elf-header-to-bzimage-fix-fix-fix.patch
i386-boot-add-an-elf-header-to-bzimage-fix-fix-fix-fix.patch

