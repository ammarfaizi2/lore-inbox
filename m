Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUGLUJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUGLUJC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUGLUJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:09:02 -0400
Received: from palrel10.hp.com ([156.153.255.245]:64193 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262085AbUGLUI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:08:58 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16626.61398.906723.300371@napali.hpl.hp.com>
Date: Mon, 12 Jul 2004 13:08:54 -0700
To: Ingo Molnar <mingo@redhat.com>
Cc: davidm@hpl.hp.com, Christoph Hellwig <hch@infradead.org>,
       Jakub Jelinek <jakub@redhat.com>, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <Pine.LNX.4.58.0407121552210.30965@devserv.devel.redhat.com>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
	<Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
	<20040711123803.GD21264@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
	<20040712182431.GB28281@infradead.org>
	<Pine.LNX.4.58.0407121428270.22224@devserv.devel.redhat.com>
	<16626.57892.533203.683465@napali.hpl.hp.com>
	<Pine.LNX.4.58.0407121552210.30965@devserv.devel.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 12 Jul 2004 15:54:56 -0400 (EDT), Ingo Molnar <mingo@redhat.com> said:

  Ingo> On Mon, 12 Jul 2004, David Mosberger wrote:

  Ingo> is it an issue? Each new port will have PT_GNU_STACK, unless they base
  Ingo> themselves on old compilers.

  >> PT_GNU_STACK is pure bloat on new architectures (and ia64).

  Ingo> EF_IA_64_LINUX_EXECUTABLE_STACK is using elf_ex->e_flags. I
  Ingo> did it the same way for x86 originally, but the tools people
  Ingo> specifically rejected it as a hack. We dont control the ELF
  Ingo> specification, but a new gcc section like PT_GNU_STACK is fair
  Ingo> game. So it might be 'bloat' but it's clean and doesnt try to
  Ingo> hijack.

I know.  All I'm saying is that when the stack permissions match the
permission which the platform uses by default, the PT_GNU_STACK header
should be omitted.

	--david
