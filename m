Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUGLT5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUGLT5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUGLT5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:57:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38277 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262080AbUGLT5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:57:36 -0400
Date: Mon, 12 Jul 2004 15:54:56 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: davidm@hpl.hp.com
cc: Christoph Hellwig <hch@infradead.org>, Jakub Jelinek <jakub@redhat.com>,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <16626.57892.533203.683465@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0407121552210.30965@devserv.devel.redhat.com>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
 <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
 <20040711123803.GD21264@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
 <20040712182431.GB28281@infradead.org> <Pine.LNX.4.58.0407121428270.22224@devserv.devel.redhat.com>
 <16626.57892.533203.683465@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Jul 2004, David Mosberger wrote:

>   Ingo> is it an issue? Each new port will have PT_GNU_STACK, unless they base
>   Ingo> themselves on old compilers.
> 
> PT_GNU_STACK is pure bloat on new architectures (and ia64).

EF_IA_64_LINUX_EXECUTABLE_STACK is using elf_ex->e_flags. I did it the
same way for x86 originally, but the tools people specifically rejected it
as a hack. We dont control the ELF specification, but a new gcc section
like PT_GNU_STACK is fair game. So it might be 'bloat' but it's clean and
doesnt try to hijack.

	Ingo
