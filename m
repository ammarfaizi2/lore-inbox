Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUCXHJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 02:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbUCXHJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 02:09:57 -0500
Received: from palrel11.hp.com ([156.153.255.246]:59801 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262960AbUCXHJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 02:09:55 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16481.13376.56992.509026@napali.hpl.hp.com>
Date: Tue, 23 Mar 2004 23:09:52 -0800
To: Ulrich Drepper <drepper@redhat.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
In-Reply-To: <4060EBEA.7080807@redhat.com>
References: <20040323231256.GP4677@tpkurt.garloff.de>
	<20040323154937.1f0dc500.akpm@osdl.org>
	<20040324002149.GT4677@tpkurt.garloff.de>
	<16480.55450.730214.175997@napali.hpl.hp.com>
	<4060E24C.9000507@redhat.com>
	<16480.59229.808025.231875@napali.hpl.hp.com>
	<4060EBEA.7080807@redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 23 Mar 2004 18:01:14 -0800, Ulrich Drepper <drepper@redhat.com> said:

  Uli> David Mosberger wrote:
  >> What stack protections other than RW- and RWX are useful?

  Uli> It's not about "what protections".  The three currently
  Uli> recognized states are PT_GNU_STACK not present, rwx, rw-.
  Uli> Ingo's code documents this.  For those who need more, I'll have
  Uli> a paper coming up for a conference in Toronto in April.

I'd find the PT_GNU_STACK approach much more appealing if it actually
was used to get rid of the stack-special case in the kernel
altogether.  Certainly it seems like it could be used to get rid of
STACK_TOP (just use the segment's p_vaddr).  That would still leave
the TASK_UNMAPPED_BASE special-case, but at least it would be a step
in the right direction.  Also, in the case of ia64, p_memsz could be
used to give user-level control over whether they want the
register/memory stacks to grow towards each other or apart from each
other.

	--david
