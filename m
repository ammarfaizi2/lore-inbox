Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSCJUyB>; Sun, 10 Mar 2002 15:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293234AbSCJUxv>; Sun, 10 Mar 2002 15:53:51 -0500
Received: from zero.tech9.net ([209.61.188.187]:65289 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293131AbSCJUxh>;
	Sun, 10 Mar 2002 15:53:37 -0500
Subject: Re: [PATCH] syscall interface for cpu affinity
From: Robert Love <rml@tech9.net>
To: Andreas Jaeger <aj@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <u8zo1g9nf8.fsf@gromit.moeb>
In-Reply-To: <1015784104.1261.8.camel@phantasy>  <u8zo1g9nf8.fsf@gromit.moeb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 10 Mar 2002 15:53:38 -0500
Message-Id: <1015793618.928.17.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-03-10 at 15:29, Andreas Jaeger wrote:
 
> Please add the procinterface also!  I've found it today (for 2.4.18)
> and it's much easier to use with existing programs.

I agree and I really like the proc-interface.  There is something uber
cool about:

	cat 1 > /proc/pid/affinity

I have a patch for 2.5.6 for proc-based affinity interface here:

	http://www.kernel.org/pub/linux/kernel/people/rml/cpu-affinity/v2.5/cpu-affinity-proc-rml-2.5.6-1.patch

I suspect, however, that despite both patches being small we really only
want to pick and standardize on one.  The syscall interface has two main
things going for it against a proc-based implementation: it is faster
and /proc may not be mounted.  The masses have spoken on this issue.

Note you can use the syscall interface with existing programs, too. 
Just write a program to take in a pid and mask and call
sched_set_affinity.

> Please add it for all archs - this is not only interesting for x86,

I'll send Linus the patch for other arches if/when he accepts this patch
- I have no problem with that.

	Robert Love

