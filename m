Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTKOFr2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 00:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTKOFr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 00:47:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:6586 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbTKOFr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 00:47:27 -0500
Date: Fri, 14 Nov 2003 21:47:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC32: cancel syscall restart on signal delivery
In-Reply-To: <Pine.LNX.4.44.0311142108060.9014-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311142141440.2101-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Nov 2003, Linus Torvalds wrote:
> 
> So the _proper_ fix (for x86) should be as appended. Agreed?

Btw, while this won't oops the machine or anything like that, I consider
bugs like this where the kernel just silently does the wrong thing to be
potentially even more serious, since they cause endless head-scratching
and the "flaky" reports.

So if somebody can come up with a way to test this sanely, it would be
nice (thinking about it I suspect that you _should_ be able to trigger
this on x86 by using the old "int 0x80" syscalls together with setting TF
in eflags).

			Linus

