Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTIZOT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTIZOT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:19:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8673 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262272AbTIZOTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:19:14 -0400
Date: Fri, 26 Sep 2003 16:19:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Syscall security
In-Reply-To: <Pine.LNX.4.44.0309261611510.6080-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.56.0309261618460.20463@localhost.localdomain>
References: <Pine.LNX.4.44.0309261611510.6080-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 Sep 2003, Maciej Zenczykowski wrote:

> Unfortunately sometimes the data transfer through stdio can be counted
> in hundreds of MB (or even in extreme cases a couple of GB), plus it is
> important to not slow down the execution of the code (we're timing and
> comparing execution speed of different approaches).  Would doing this
> via ptrace increase the runtime of the parent pid or of the child pid or
> both?  ie. would this make any syscall costly timewise (stdio is either
> from a ram disk or piped to/from a generating/checking process) or would
> this be unnoticeable?

you can measure this effect by doing "strace -o /dev/null <program>" of
such a program. (strace will have higher overhead than a simple syscall
filtering ptrace app, but it should show you the kind of effects ptrace
causes.)

	Ingo
