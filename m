Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269715AbTGJXmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269718AbTGJXmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:42:04 -0400
Received: from ns.suse.de ([213.95.15.193]:16394 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269715AbTGJXk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:40:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.75
References: <20030710223548.A20214@flint.arm.linux.org.uk.suse.lists.linux.kernel>
	<Pine.LNX.4.44.0307101512350.4757-100000@home.osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Jul 2003 01:55:26 +0200
In-Reply-To: <Pine.LNX.4.44.0307101512350.4757-100000@home.osdl.org.suse.lists.linux.kernel>
Message-ID: <p73isqaos29.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
> 
> Also, the only real point of a stable release is for distribution makers.
> That pretty much cuts the list of "needs to be supported" down to x86,
> ia64, x86-64 and possibly sparc/alpha.

No ppc, ppc64, s390?

Current bad issues for x86-64: 

- IDE Taskfile IO when enabled corrupts file systems on AMD8111
(on others too?).  This is the worst because there is no fix available.
I would propose to completely disable taskfile in Kconfig 
until the issue is resolved.

- Reiserfs zeroes every second 4K block in any write >4K on 64bit systems
(patch is in -mm*). Hopefully the patch can be merged before 2.6-pre.

and 

- doesn't compile (trivial fixes are already sent) 

-Andi
