Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264582AbUFLCx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbUFLCx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 22:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbUFLCx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 22:53:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:657 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264582AbUFLCxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 22:53:53 -0400
Date: Fri, 11 Jun 2004 22:53:48 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: stian@nixia.no
cc: linux-kernel@vger.kernel.org
Subject: Re: timer + fpu stuff locks my console race
In-Reply-To: <1701.83.109.60.63.1086814977.squirrel@nepa.nlc.no>
Message-ID: <Pine.LNX.4.44.0406112252160.13607-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004 stian@nixia.no wrote:

> I'm doing some code tests when I came across problems with my program
> locking my console (even X if I'm using a xterm).

Reproduced here, on my test system running a 2.6 kernel.
I did get a kernel backtrace over serial console, though ;)

Pid: 19752, comm:      kernel-hang-bz1
EIP: 0060:[<ffff345c>] CPU: 0
EIP is at 0xffff345c
 EFLAGS: 00000202    Not tainted  (2.6.5-1.332)
EAX: 00000001 EBX: 12005870 ECX: fef32ea8 EDX: 1958f000
ESI: 1958f000 EDI: fef32ea8 EBP: fef32e48 DS: 007b ES: 007b
CR0: 80050033 CR2: 00c4b720 CR3: 003ab000 CR4: 000006d0
Call Trace:
 [<0210dcda>] restore_i387_fxsave+0x18/0x60
 [<0210dd38>] restore_i387+0x16/0x65
 [<021059e5>] restore_sigcontext+0xf2/0x10c
 [<0215b737>] get_user_size+0x30/0x57
 [<02105c13>] sys_sigreturn+0x214/0x23a


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

