Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbTIZOK3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbTIZOK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:10:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51423 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262241AbTIZOKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:10:24 -0400
Date: Fri, 26 Sep 2003 16:10:56 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Syscall security
In-Reply-To: <Pine.LNX.4.44.0309261553180.6080-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.56.0309261609160.20113@localhost.localdomain>
References: <Pine.LNX.4.44.0309261553180.6080-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 Sep 2003, Maciej Zenczykowski wrote:

> The reason I'm asking is because I want to run totally untrusted
> statically linked binary code (automatically compiled from user
> submitted untrusted sources) which only needs read/write access to stdio
> which means it only requires syscalls read/write/exit + a few more for
> memory alloc/free (like brk) + a few more generated before main is
> called (execve and uname I believe).

if this syscall activity is so low then it might be much more flexible to
control the binary via ptrace and reject all but the desired syscalls.  
This will cause a context switch but if it's stdio only then it's not a
big issue. Plus this would work on any existing Linux kernel.

	Ingo
