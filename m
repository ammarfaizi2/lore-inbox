Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131290AbRCWSha>; Fri, 23 Mar 2001 13:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131309AbRCWShV>; Fri, 23 Mar 2001 13:37:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38159 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131290AbRCWShJ>; Fri, 23 Mar 2001 13:37:09 -0500
Subject: Re: [PATCH] Prevent OOM from killing init
To: Andries.Brouwer@cwi.nl
Date: Fri, 23 Mar 2001 18:38:37 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200103231829.TAA06442.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at Mar 23, 2001 07:29:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gWSN-0005CQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> infinite storage. After all, earlier Unix flavours did not need
> an OOM killer either, and my editor was not killed under Unix V6
> on 64k when I started some other process.

You were lucky. Its quite possible for V6 to kill processes when you run out
of swap

> The old Unix guarantee that a program only crashes because of
> its own behaviour is lost. That is very sad.

No such guarantee ever existed. There are systems that had stuff like per
user memory quotas but those were mostly much more mainframe oriented

> 200 MB then the rest of that memory is not wasted. But it can
> only be used for things that can be freed when needed, like
> inode and buffer cache.

No. You cannot free the inode and buffer cache arbitarily. You only have a
probability - that puts you back at square 1.

> But inefficient or not, I much prefer a system with guarantees,
> something that is reliable by default, above something that
> works well if you are lucky and fails at unpredictable moments.

malloc is merely an accounting exercise (actually its mostly mmap 
accounting). ptrace is the only quirk. Nobody feels its very important because
nobody has implemented it.

Alan

