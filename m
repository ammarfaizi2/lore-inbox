Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRAKREr>; Thu, 11 Jan 2001 12:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129798AbRAKREh>; Thu, 11 Jan 2001 12:04:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17163 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129967AbRAKREc>; Thu, 11 Jan 2001 12:04:32 -0500
Subject: Re: Kernel (2.4.0) lock-up in "write" (using PTS).
To: alvieboy@alvie.com (Alvaro Lopes)
Date: Thu, 11 Jan 2001 17:06:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A5BEA90.D3B68DCD@alvie.com> from "Alvaro Lopes" at Jan 10, 2001 04:52:32 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GlBB-0002bL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.0 Kernel hangs up when I do the following stuff:
> 
> 	* Create a new PTY using openpty();
> 	* Fork using forkpty. Now, the child process does this:
> 		- Set the fd 0 line discipline to PPP;
> 		- tries infinitely to read the standard input.
> 
> 	The parent process sets the line discipline of the master PTY fd to PPP
> also, and then writes to it.
> When I say it hangs up I really mean it. Not even the SYSRQ works.

Does this still happen on -ac ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
