Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317577AbSGOSRz>; Mon, 15 Jul 2002 14:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317572AbSGOSRy>; Mon, 15 Jul 2002 14:17:54 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:37645 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317576AbSGOSRw>;
	Mon, 15 Jul 2002 14:17:52 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207151820.g6FIKVi215656@saturn.cs.uml.edu>
Subject: Re: HZ, preferably as small as possible
To: davidm@hpl.hp.com
Date: Mon, 15 Jul 2002 14:20:31 -0400 (EDT)
Cc: rmk@arm.linux.org.uk (Russell King),
       acahalan@cs.uml.edu (Albert D. Cahalan),
       torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <15666.61141.799053.70367@napali.hpl.hp.com> from "David Mosberger" at Jul 15, 2002 08:48:37 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger writes:

> libproc should be using AT_CLKTCK (as provided via sysconf(_SC_CLK_TCK))
> at any rate.

If that would work reliably, sure. The glibc hackers have had
some trouble with doing a correct implementation. I've heard
that recently the kernel has been supplying glibc with HZ via
the ELF note mechanism, but I've no way to tell a broken glibc
from a working one. Thus libproc does things the painful way.

Perhaps you could explain how to access ELF notes from
regular app code. That covers 2.4 kernels AFAIK, and so
the hacks could go away as soon as Debian retires the
2.2 kernel.

