Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUEZXdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUEZXdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 19:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUEZXdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 19:33:49 -0400
Received: from cantor.suse.de ([195.135.220.2]:15811 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261206AbUEZXdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 19:33:42 -0400
Date: Thu, 27 May 2004 01:33:39 +0200
From: Andi Kleen <ak@suse.de>
To: Chris.Gottbrath@etnus.com
Cc: chrisg@etnus.com, marcelo@conectiva.com.br, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, jdelsign@etnus.com
Subject: Re: [PATCH] x86-64 only: ia32entry.S reg changes dropped during
 debugging
Message-Id: <20040527013339.60f590cf.ak@suse.de>
In-Reply-To: <Pine.LNX.4.58.0405261822370.8575@papua.etnus.com>
References: <Pine.LNX.4.58.0405261822370.8575@papua.etnus.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 18:50:11 -0400 (EDT)
Chris Gottbrath <chrisg@etnus.com> wrote:

> 
> Andi, 
> 
> We develop a debugger for linux x86-64 called TotalView. We have 
> recently tracked down a problem to the fact that some register changes
> made by the debugger in the target are getting discarded. This is only 
> happening with the 2.4.x kernels on x86-64. It appears that the 
> bug may have been fixed as a side effect of some other change in 2.6.x.
> 
> The scenario is that the debugger uses ptrace(PTRACE_SYSCALL,) and 
> changes some registers in the process while it is stopped in a
> system call. We are finding that the system call entry code discards 
> changes to R15, R14, R13, R12, RBP, and RBX.
> 
> The following patch is against arch/x86_64/ia32/ia32entry.S in 2.4.26.

Looks good. Thanks.

-Andi

