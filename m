Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTIZOQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbTIZOQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:16:58 -0400
Received: from gaia.cela.pl ([213.134.162.11]:64261 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262258AbTIZOQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:16:57 -0400
Date: Fri, 26 Sep 2003 16:16:52 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Syscall security
In-Reply-To: <Pine.LNX.4.56.0309261609160.20113@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0309261611510.6080-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if this syscall activity is so low then it might be much more flexible to
> control the binary via ptrace and reject all but the desired syscalls.  
> This will cause a context switch but if it's stdio only then it's not a
> big issue. Plus this would work on any existing Linux kernel.

Unfortunately sometimes the data transfer through stdio can be counted in 
hundreds of MB (or even in extreme cases a couple of GB), plus it is 
important to not slow down the execution of the code (we're timing and 
comparing execution speed of different approaches).  Would doing this via 
ptrace increase the runtime of the parent pid or of the child pid or both?  
ie. would this make any syscall costly timewise (stdio is either from a 
ram disk or piped to/from a generating/checking process) or would this be 
unnoticeable?

Thx,
MaZe.

