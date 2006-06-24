Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWFXPWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWFXPWf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWFXPWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:22:35 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:48028 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750825AbWFXPWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:22:34 -0400
Date: Sat, 24 Jun 2006 11:22:35 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-ID: <20060624152235.GB3627@ccure.user-mode-linux.org>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org> <20060623024222.GA8316@ccure.user-mode-linux.org> <20060623210714.GA16661@thunk.org> <20060623214623.GA7319@ccure.user-mode-linux.org> <20060624140001.GA7752@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624140001.GA7752@thunk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 10:00:01AM -0400, Theodore Tso wrote:
> 32% ./linux
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking for tmpfs mount on /dev/shm...OK
> Checking PROT_EXEC mmap in /dev/shm/...OK
> Checking for the skas3 patch in the host:
>   - /proc/mm...not found
>   - PTRACE_FAULTINFO...not found
>   - PTRACE_LDT...not found
> UML running in SKAS0 mode
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> 
> <tytso@candygram>       {/usr/projects/uml/linux-2.6.17-mm1}
> 33%
> 
> Looks like UML just crashed (tm), without any explanation.  Kconfig
> attached.  Suggestions on how to debug this would be appreciated.

I'm working on this - the genirq stuff in -mm broke UML.  Add stderr=1
to the command line to see the actual crash.  2.6.17 is fine, except
you need a klibc patch for O= builds.

				Jeff
