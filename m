Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWHSXBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWHSXBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 19:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWHSXBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 19:01:21 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:46599 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751568AbWHSXBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 19:01:21 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPL Violation?
Date: Sat, 19 Aug 2006 16:01:14 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEEJNOAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <20060819113052.GC3190@aitel.hist.no>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 19 Aug 2006 15:56:10 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 19 Aug 2006 15:56:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Now, if someone actually distributes a closed-source module that
> circumvents EXPORT_SYMBOL_GPL, or relies on an accompagnying
> open source patch that removes the mechanism, this happens:

> 1. By doing this, they clearly showed that their module is outside the
>    gray area of "allowed binary-only modules". They definitively
>    made a "derived work" and distributed it.

	How do you figure? This seems to me to be an amazing leap with no rationale
of any kind to justify it.

> 2. Anybody who received this module may now invoke the GPL
>    (and the force of law, if necessary) to extract the
>    module source code from the maker.  And then this source
>    can be freely redistributed to all interested.

	A trivial patch to the kernel just to remove a deliberate incompatibility
isn't sufficient alone to change the status of the module. The patch to
remove EXPORT_SYMBOL_GPL could even be developed by a completely different
group of people from the kernel module, with no overlap of any kind, so it
is absurd to say that the kernel patch somehow changes the status of the
module.

	To give you an analogy, suppose I made a closed-source filesystem for
FreeBSD. Somebody made a patch to the Linux kernel to allow it to emulate
the BSD filesystem interface well enough that with that patch, Linux can use
my module. By any stretch of the imagination, can this Linux patch change
the copyright status of my module, given that it was developed by different
people?

	Yes, the patch to modify the kernel is clearly a derivative work, but the
module the patch is needed for is still not if it wasn't before.

	In fact, any arguments you could make before, you can still make. But no
new ones arise. For example, if you could argue that the kernel and the
module were too tightly integrated in their design to be considered separate
works or that the module includes too much of the kernel, you still can. But
those are the arguments you'd need to make, and needing a kernel patch that
is independent of the module (authorwise) doesn't strengthen any of them.

> So the rights management system works really well - it provides an
> enforceable "the price for using these symbols is your code".

	It can't do that. The module must be GPL'd if and only if it's a derivative
work of the Linux kernel. This has to do with whether it contains portions
of the Linux kernel beyond what is covered by things like fair use and
scenes a faire. How does EXPORT_SYMBOL_GPL change that?

> The mechanism itself is not protected by laws like the DMCA, because
> its removal is explicitly allowed.  The great thing is, protection
> of the _content_ is not lost when this happens.

	Huh?

	I do agree with the point that you do need to explicitly act to circumvent
EXPORT_MODULE_GPL and that pointing out that you did that may be helpful in
subsequent legal fights that may arise. But I don't think anyone today can
specify precisely how. (Perhaps if someone claimed they had no idea that
they might be making their module a derivative work, that they must have
known could affect a damage award.)

	DS


