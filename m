Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266618AbUBLVpr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266621AbUBLVpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:45:47 -0500
Received: from palrel12.hp.com ([156.153.255.237]:28836 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266618AbUBLVpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 16:45:44 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16427.62469.402989.657402@napali.hpl.hp.com>
Date: Thu, 12 Feb 2004 13:45:41 -0800
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] bogus __KERNEL_SYSCALLS__ usage
In-Reply-To: <20040212162856.GU12634@redhat.com>
References: <20040212162856.GU12634@redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 12 Feb 2004 16:28:57 +0000, Dave Jones <davej@redhat.com> said:

  Dave> arch/ia64/kernel/smp.c
  Dave> arch/ia64/kernel/smpboot.c

Looks like these don't need __KERNEL_SYSCALLS__ anymore.

  Dave> arch/ia64/kernel/process.c

This one still needs it, because it calls clone() and _exit().

I'll fix the former two in my tree.

Thanks,

	--david
