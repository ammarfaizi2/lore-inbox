Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282824AbRLKVP6>; Tue, 11 Dec 2001 16:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283488AbRLKVPj>; Tue, 11 Dec 2001 16:15:39 -0500
Received: from waste.org ([209.173.204.2]:56495 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S282824AbRLKVP2>;
	Tue, 11 Dec 2001 16:15:28 -0500
Date: Tue, 11 Dec 2001 15:15:21 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Brian Horton <go_gators@mail.com>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to debug a deadlock'ed kernel?
In-Reply-To: <3C166540.DC0BDBEE@mail.com>
Message-ID: <Pine.LNX.4.40.0112111508390.32074-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001, Brian Horton wrote:

> Anyone got any good tips on how to debug a SMP system that is locked up
> in a deadlock situation in the kernel? I'm working on a kernel module,
> and after some number of hours of stress testing, the box locks up. None
> of the sysrq options show anything on the display, though the reBoot
> option does reboot the system. RedHat 6.2 and its 2.2.14 kernel. Doesn't
> hang for me on 2.4, so I need to debug it here...

You might try Keith Owen's kdb. When you lock-up, hit <pause> which brings
up a kdb prompt. From there you can do backtraces, memory examination, and
disassembly on either processor.

It's often quite helpful to modify your test to narrow down what is making
it crash and/or make it happen faster. Reads vs writes, short/long
packets, etc.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

