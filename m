Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWD1UvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWD1UvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 16:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWD1UvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 16:51:03 -0400
Received: from www.osadl.org ([213.239.205.134]:30132 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751451AbWD1UvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 16:51:02 -0400
Subject: Re: [BUG 2.6.16-rt18] BUG at kernel/rtmutex.c:639!
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Vernon Mauery <vernux@us.ibm.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200604280713.45219.vernux@us.ibm.com>
References: <200604280713.45219.vernux@us.ibm.com>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 22:53:09 +0200
Message-Id: <1146257590.1322.637.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 07:13 -0700, Vernon Mauery wrote:
> Ingo,
> 
> On an IBM Intellistation A-Pro I am seeing the bug regularly as seen below.
> We also see this bug on an LS-20 blade.  The way this bug is triggered is
> to add 'irqpoll' to the kernel command line.  If we remove this from the
> command line, we don't see this bug.  I know the easy answer is that if you
> don't want to see the bug, don't use irqpoll.  So we don't.  But we thought
> that just in case this bug does expose something real that it should be
> reported.

That's a lock recursion caused by the irqpoll option. Needs some
thoughts to fix it. Thanks for reporting though.

	tglx


