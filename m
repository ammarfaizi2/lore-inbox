Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264169AbRFFVg2>; Wed, 6 Jun 2001 17:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264172AbRFFVgS>; Wed, 6 Jun 2001 17:36:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41744 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264169AbRFFVgK>; Wed, 6 Jun 2001 17:36:10 -0400
Subject: Re: Break 2.4 VM in five easy steps
To: dglidden@illusionary.com (Derek Glidden)
Date: Wed, 6 Jun 2001 22:34:08 +0100 (BST)
Cc: helgehaf@idb.hist.no (Helge Hafting), linux-kernel@vger.kernel.org
In-Reply-To: <3B1E437C.D5D339EB@illusionary.com> from "Derek Glidden" at Jun 06, 2001 10:51:40 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157kwK-0000U0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> interfering with the kernel scheduler then that's also bad because there
> absolutely *are* other processes that should be getting time, like the
> console windows/shells at which I'm logged in.  If they aren't getting
> it specifically because the VM is preventing them from receiving
> execution time, then that's another bug.

Its in fact very important the VM interferes with scheduling. When a task is
a heavy generator of dirty pages it has to be throttled to get fair use of
disk bandwidth and memory

Similarly its desirable as paging rates increase to ensure that everything
gets some running time to make progress even at the cost of interactivity.
This is something BSD does that we don't. Arguably nowdays its reasonable to
claim you should have enough ram to avoid the total thrash state that BSD
handles this way o course

