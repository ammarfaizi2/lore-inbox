Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbUBDVEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266608AbUBDVC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:02:57 -0500
Received: from smtp07.auna.com ([62.81.186.17]:60082 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S266605AbUBDVCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:02:17 -0500
Date: Wed, 4 Feb 2004 22:02:12 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Randazzo, Michael" <RANDAZZO@ddc-web.com>
Cc: "'Valdis.Kletnieks@vt.edu'" <Valdis.Kletnieks@vt.edu>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.x POSIX Compliance/Conformance...
Message-ID: <20040204210212.GA2646@werewolf.able.es>
References: <89760D3F308BD41183B000508BAFAC4104B16F38@DDCNYNTD>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B16F38@DDCNYNTD> (from RANDAZZO@ddc-web.com on Wed, Feb 04, 2004 at 21:18:17 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.02.04, "Randazzo, Michael" wrote:
> Where are the kernel calls defined for locks and semaphores?
> 
> How come the kernel headers don't define Posix.4 
> semaphores (_POSIX_SEMAPHROES) or Posix itself
> (_POSIX_VERSION is undefined)
> 

The kernel internals are not nor Posix, nor SysV nor anything. It is just
by chance (or logic ;)) that some functions in kernel are named like the
userspace similars. Kernel source is in its own namespace.

One example (not a syscall, but useful I expect):
- Kernel has a 'sys_clone()' function, numbered __NR_clone
- GLibc implements a linux-specific system-call 'clone()', using sys_clone
- Glibc uses 'clone()' to implement 'fork()'

So, don't try to look for fork() inside the kernel.

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc3-jam1 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
