Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVDXB7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVDXB7z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 21:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVDXB7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 21:59:55 -0400
Received: from mail.dif.dk ([193.138.115.101]:61847 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262229AbVDXB7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 21:59:48 -0400
Date: Sun, 24 Apr 2005 04:02:59 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: mbellett@cs.unibo.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel BUG() in exit.c in ptrace/pthread interaction
In-Reply-To: <20050424014834.GA31463@cs.unibo.it>
Message-ID: <Pine.LNX.4.62.0504240400040.2474@dragon.hyggekrogen.localhost>
References: <20050424014834.GA31463@cs.unibo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2005 mbellett@cs.unibo.it wrote:

> When you run the program in attachment, *even as an ordinary user*, the kernel
> panic. Tested kernel is a 2.6.11.7 vanilla with alleged .config. Tested with

Just tried running it on my box here with a 2.6.12-rc2-mm3 kernel and it 
survived just fine.
Here's what I did and the output I got : 

$ gcc -lpthread ptrace-thread-bug.c
ptrace-thread-bug.c:158:2: warning: no newline at end of file
$ ./a.out
child: pid=5664
child: self sigstopping
father: pid=5663
father: waiting child's selfstopping
father: making child go again under ptrace
father: detaching
father: thread creation
father: waiting for end
thread 16386: attaching
thread 16386: unlocking
father: destroying semaphore
father: all done
thread 16386: unlocking child
$ 

-- 
Jesper Juhl

