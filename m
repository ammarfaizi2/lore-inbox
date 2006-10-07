Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423028AbWJGATO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423028AbWJGATO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 20:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423026AbWJGATO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 20:19:14 -0400
Received: from ozlabs.org ([203.10.76.45]:52971 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1423024AbWJGATM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 20:19:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17702.62074.410366.433781@cargo.ozlabs.ibm.com>
Date: Sat, 7 Oct 2006 10:19:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] powerpc: fixup after irq changes
In-Reply-To: <20061006203434.GA7932@aepfle.de>
References: <20061002132116.2663d7a3.akpm@osdl.org>
	<20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	<20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	<18975.1160058127@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0610051632250.3952@g5.osdl.org>
	<20061006203434.GA7932@aepfle.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering writes:

> remove struct pt_regs * from all handlers.
> compile tested with arch/powerpc/config/* and
> arch/ppc/configs/prep_defconfig

You also removed the regs argument from the get_irq functions.  That
is a separate unrelated change, which I would want to think about for
a bit, because at least at one stage I had a use for that parameter.

So the patch is NAK'd as to that part.  I have some patches queued up
already which do some of the other fixes too.  Thanks for your efforts
on this though.

Regards,
Paul.
