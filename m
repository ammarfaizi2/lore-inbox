Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263091AbUKTDnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbUKTDnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 22:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbUKTDl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 22:41:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59776 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263093AbUKTDki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 22:40:38 -0500
Date: Fri, 19 Nov 2004 19:40:22 -0800
Message-Id: <200411200340.iAK3eM9S009722@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
X-Fcc: ~/Mail/linus
Cc: Eric Pouech <pouech-eric@wanadoo.fr>, Linus Torvalds <torvalds@osdl.org>,
       Mike Hearn <mh@codeweavers.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: Daniel Jacobowitz's message of  Friday, 19 November 2004 16:23:28 -0500 <20041119212327.GA8121@nevyn.them.org>
X-Zippy-Says: Not SENSUOUS...  only ``FROLICSOME''...  and in need of DENTAL
   WORK...  in PAIN!!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm getting the feeling that the question of whether to step into
> signal handlers is orthogonal to single-stepping; 

No, it's not.  You only ever step into a handler when you ask to.
That's already the interface.

> Platforms which don't implement PTRACE_SINGLESTEP would probably
> appreciate this.  A "single step" which stops you after setting up the
> signal trampoline and adjusting the PC, before executing any
> instructions in the handler.

That's what PTRACE_SINGLESTEP with a nonzero signal number does since it
was fixed.
