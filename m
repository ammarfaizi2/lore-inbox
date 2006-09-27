Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030730AbWI0T4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030730AbWI0T4I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030729AbWI0T4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:56:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16532 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030728AbWI0T4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:56:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       "Luck, Tony <tony.luck@intel.com>"@ebiederm.dsl.xmission.com,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/5] Message signaled irq handling cleanups
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Date: Wed, 27 Sep 2006 13:54:44 -0600
Message-ID: <m17izpm6ez.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch set should be enough to clear up the
outstanding issues with genirq on i386 and x86_64.  This actually
takes things a step farther and moves all of architecture
dependencies I could find into the appropriate architecture.

So hopefully we are finally close enough that other architectures
will be able implement msi support, without too much trouble.

msi: Simplify msi sanity checks by adding with generic irq code.
msi: Only use a single irq_chip for msi interrupts
msi: Refactor and move the msi irq_chip into the arch code.
msi: Move the ia64 code into arch/ia64
htirq: Tidy up the htirq code

Eric
