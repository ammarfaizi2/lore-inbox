Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTERGdF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 02:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTERGdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 02:33:05 -0400
Received: from zero.aec.at ([193.170.194.10]:38155 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261159AbTERGdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 02:33:03 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix, v4
From: Andi Kleen <ak@muc.de>
In-Reply-To: <20030516233013$140e@gated-at.bofh.it> (Andrew Morton's message
 of "Sat, 17 May 2003 01:30:13 +0200")
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <20030516233011$3c2c@gated-at.bofh.it>
	<20030516233013$140e@gated-at.bofh.it>
Date: Sun, 18 May 2003 08:45:54 +0200
Message-ID: <m3k7cohhwd.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> arch/x86_64/
> ------------
> - time handling is broken. Need to move up 2.4 time.c code.
[...]
> - some fixes from 2.4 still need to be merged

This is done (except the time.c stuff) 

> - 32bit vsyscalls seem to be broken
>
> - 32bit elf coredumps are broken

These two are fixed.

>
> - need to coredump 64bit vsyscall code with dwarf2

This has been started, but is stalled due to binutils/gcc issues.

>
> - move 64bit signal trampolines into vsyscall code and add dwarf2 for it.

First part of it has been done. Just need to add the dwarf2. Also requires
the previous item.

>
> - describe kernel assembly with dwarf2 annotations for kgdb (currently
>   waiting on some binutils changes for this) 

binutils patch for it exists now, still need to get the hands dirty on it.

But all hasn't been merged yet because Linus drops patches recently :-(

-Andi
