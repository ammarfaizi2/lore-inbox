Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVCCVt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVCCVt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVCCVmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:42:06 -0500
Received: from fire.osdl.org ([65.172.181.4]:8618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262618AbVCCViu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:38:50 -0500
Date: Thu, 3 Mar 2005 13:38:57 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303133857.779e5f68@dxpl.pdx.osdl.net>
In-Reply-To: <1109883750.591.47.camel@localhost.localdomain>
References: <42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<422674A4.9080209@pobox.com>
	<Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	<42268749.4010504@pobox.com>
	<20050302200214.3e4f0015.davem@davemloft.net>
	<42268F93.6060504@pobox.com>
	<4226969E.5020101@pobox.com>
	<20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com>
	<20050303080459.GA29235@kroah.com>
	<4226CA7E.4090905@pobox.com>
	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	<422751C1.7030607@pobox.com>
	<Pine.LNX.4.58.0503031022100.25732@ppc970.osdl.org>
	<1109883750.591.47.camel@localhost.localdomain>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In all this discussion, I see a couple of underlying problems. The first
is what is the definition of stability.  To many (mostly kernel developers)
the definition of stability "S" depends on number of bug reports "B":

	S(infinite) = B(0)
	S(X) > S(Y) iff B(X) < B(Y)

The problem is that the kernel community never sees many problems (filtered
through distro's), and the severity and importance of problem reports
is confused. Bug tracking could help, but it would have to be universal
and painless; bugzilla doesn't cut it.

But many end-user's and IT types seem to feel that the definition 
of stability is based on rate of change, ie patches (P) over time.
	
	S(X) > S(Y) iff P(X)/t > P(Y)/t

These are the people who can't believe 2.6 is stable because they see so
much change. Having 2.6.x.y may make this group happy, but probably only
after such a long period that the the mainline kernel is 6 months ahead.

The whole point of the continuous 2.6 process, was to avoid having the 
multiple tree backporting mess that 2.5/2.4 had, especially the distro kernels
were all some hodge-podge of 2.5 and 2.4 stuff. Fixing the same bug on multiple
branches is a fundamentally flawed process that is sure to allow some bug fixes
to be missed.

The third group are those that install release 2.6.X and have some problem;
nobody wants to believe their problem is unique. So often, the user says makes
the fallacious argument that "if I had a problem, then all users will have the
problem, therefore it is unstable." These people will never be happy, they can
stay on 2.2.
