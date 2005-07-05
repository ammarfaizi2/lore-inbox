Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVGEOcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVGEOcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 10:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVGEOcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 10:32:32 -0400
Received: from ns1.suse.de ([195.135.220.2]:64685 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261867AbVGEOQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 10:16:52 -0400
Date: Tue, 5 Jul 2005 16:16:51 +0200
From: Andi Kleen <ak@suse.de>
To: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64: ptrace ia32 BP fix
Message-ID: <20050705141651.GW21330@wotan.suse.de>
References: <200507050931.j659VFEa028271@magilla.sf.frob.com> <20050705140724.GA19552@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050705140724.GA19552@nevyn.them.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wouldn't this  to botch a debugger which supported both backtracing and
> PTRACE_SYSCALL, when stopped in a syscall?  We have unwind information
> for the VDSO and it's not going to tell us that the kernel has done
> something clever to the value of %ebp.

The kernel is indeed not supposed to modify any input
registers of syscalls (ok except rcx, but that is unavoidable)

-Andi
