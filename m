Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbRIDTTT>; Tue, 4 Sep 2001 15:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267621AbRIDTTJ>; Tue, 4 Sep 2001 15:19:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60429 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267520AbRIDTTC>; Tue, 4 Sep 2001 15:19:02 -0400
Subject: Re: help!! tons of Z processes in 2.4.x (x > 3)
To: linux4u@wanadoo.es (Pau Aliagas)
Date: Tue, 4 Sep 2001 20:23:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (lkml), alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33.0109042049500.2038-100000@pau.intranet.ct> from "Pau Aliagas" at Sep 04, 2001 09:02:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15eLmy-0004Ki-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since 2.4.6-ac[45] until 2.4.9-ac7 I keep on getting processes in Z
> state, mainly identd (spawned from an identd daemon), galeon (the gnome
> browser) and mysqld.

Sounds like user mode problems to me. Z is a zombie - its waiting for its
parent to wake up and collect its exit code. Look at their ppid see what
the parent is and is doing

> An strace to the process ends immediately with the following message:
> # strace -p 3697
> attach: ptrace(PTRACE_ATTACH, ...): Operation not permitted
> It doesn't matter wheater I'm root or not.

Yep - it doesnt really exist except as a process slot

> If I run the redhat-7.1 kernel (kernel-2.4.3-12) this doesn=A1't happen, =
> so
> I deduce it has something to do with recent changes.
> 
> I'm surprised that I'm the only one with this problem.

So far you are

Alan
