Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292245AbSBTTou>; Wed, 20 Feb 2002 14:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292239AbSBTToc>; Wed, 20 Feb 2002 14:44:32 -0500
Received: from zero.tech9.net ([209.61.188.187]:27155 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292244AbSBTToO>;
	Wed, 20 Feb 2002 14:44:14 -0500
Subject: Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
From: Robert Love <rml@tech9.net>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
        Paul Jackson <pj@engr.sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.21.0202201826120.7476-100000@sx6.ess.nec.de>
In-Reply-To: <Pine.LNX.4.21.0202201826120.7476-100000@sx6.ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Feb 2002 14:44:12 -0500
Message-Id: <1014234254.18361.43.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-20 at 12:57, Erich Focht wrote:

> The patch is for 2.5.4-K3. I'm actually developing on IA-64 and tested it
> on Itanium systems based on 2.4.17 kernels where it survived my
> tests. I hope this works for i386 and is helpful to someone.

I was working on the same thing myself.  I don't have a working
solution, so you beat me, and thus good job.  I think we need this, for
various reasons, especially to implement a method of setting task
affinity that we can export to userspace.

I am a little surprised by how much code it took, though.  Do we need
the function to act asynchronously?  In other words, is it a requirement
that the task reschedule immediately, or only that when it next
reschedules it obeys its affinity?

Also, what is the reason for allowing multiple calls to
set_cpus_allowed?  How often would that even occur?

	Robert Love

