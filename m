Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282324AbRKXBXE>; Fri, 23 Nov 2001 20:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282322AbRKXBWz>; Fri, 23 Nov 2001 20:22:55 -0500
Received: from ns01.netrox.net ([64.118.231.130]:65175 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S282324AbRKXBWm>;
	Fri, 23 Nov 2001 20:22:42 -0500
Subject: Re: Error: compiling with preempt-kernel-rml-2.4.15-1.patch
From: Robert Love <rml@tech9.net>
To: listmail@majere.epithna.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111231906210.3406-100000@majere.epithna.com>
In-Reply-To: <Pine.LNX.4.33.0111231906210.3406-100000@majere.epithna.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 23 Nov 2001 20:21:24 -0500
Message-Id: <1006564887.1343.7.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-23 at 19:13, listmail@majere.epithna.com wrote:
> I applied the preempt-kernel-rml-2.4.15-1.patch file to a clean
> just untarred 2.14.15 kernel source, and began to compile got the
> following error.
> I know the source is good, I compiled a non-patched Kernel from the same
> archive earlier, re-extracted after the error, repeated, redownloaded,
> reextracted. repeated.

Hm, that is what I get for trying to get a release out while away for
Thanksgiving ...

try changing:
	if (task_on_runqueue(prev) && !prev->has_cpu)
to:
	if (task_on_runqueue(prev) && !task_has_cpu(prev))
in kernel/sched.c on line 509.

I'll put a new revision of the patch out when I get a chance ...

	Robert Love


