Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263177AbVCKFNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbVCKFNr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbVCKFNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:13:46 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:58511 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263177AbVCKFL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:11:26 -0500
Subject: Re: binary drivers and development
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: diegocg@gmail.com, lsorense@csclub.uwaterloo.ca, riel@redhat.com,
       nigelenki@comcast.net
Content-Type: text/plain
Date: Thu, 10 Mar 2005 23:57:50 -0500
Message-Id: <1110517070.1949.60.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen writes:

> You forgot the very important:
>    - Only works on architecture it was compiled for.  So anyone not
>      using i386 (and maybe later x86-64) is simply out of luck.  What do
>      nvidia users that want accelerated nvidia drivers for X DRI do
>      right now if they have a powerpc or a sparc or an alpha?  How about
>      porting Linux to a new architecture.  With binary drivers you now
>      start out with no drivers on the new architecture except for the
>      ones you have source for.  Not very productive.

Rik van Riel writes:

> No, it wouldn't.  I can use a source code driver on x86,
> x86-64 and PPC64 systems, but a binary driver is only
> usable on the architecture it was compiled for.
>
> Source code is way more portable than binary anything.

The kernel already has an AML interpreter for ACPI. **duck**

As for portability, AML would do the job. It beats typical
vendor source code IMHO, because endianness and integer size
are well-defined. (like the Java VM and .net)

For the x86 and ia64 users, the AML interpreter is probably
already compiled into the kernel. Most people need it to
set up SMP or power management. So, no added bloat even.

AML code is fairly well controlled and isolated. There is
of course the backdoor via DMA for the truly determined
evil author, but such paranoia is rather extreme. AML is
really designed for this sort of task.

As with any interpreter, there are ways (JIT) to make the
AML interpreter go faster if need be.


