Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbUBGAhq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265657AbUBGAhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:37:46 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:38559
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265636AbUBGAho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:37:44 -0500
Message-ID: <4024333B.6020805@redhat.com>
Date: Fri, 06 Feb 2004 16:37:15 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       Andi Kleen <ak@suse.de>, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <20040205214348.GK31926@dualathlon.random> <Pine.LNX.4.44.0402052314360.5933-100000@chimarrao.boston.redhat.com> <20040206042815.GO31926@dualathlon.random> <40235D0B.5090008@redhat.com> <20040206154906.GS31926@dualathlon.random>
In-Reply-To: <20040206154906.GS31926@dualathlon.random>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> by the same argument the 2.6 i386 vsyscall is not acceptable too since
> it has an hardcoded address too that is the same for all binary kernels
> that you ship, and furthmore it has the sysenter or int 0x80 hardcoded
> at a fixed address to jump into.

You don't read what I write.

The official kernel might have the vdso at a fixed address part no part
of the ABI requires this address and so anybody with some security
conscience can change the kernel to randomize the vdso address.  It's
not my or Ingo's fault that Linus doesn't like the exec-shield code
which would introduce the randomization.  The important aspect is that
we can add vdso randomization and nothing else needs changing.  The same
libc will run6 on a stock kernel and the one with the randomized vdso.
This is not the case on x86-64 where the absolute address for the
gettimeofday is used.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
