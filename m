Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132718AbRAKQsx>; Thu, 11 Jan 2001 11:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132720AbRAKQsn>; Thu, 11 Jan 2001 11:48:43 -0500
Received: from p020-53.netc.pt ([213.30.21.20]:21764 "EHLO thecrypt.utad.pt")
	by vger.kernel.org with ESMTP id <S132718AbRAKQs3>;
	Thu, 11 Jan 2001 11:48:29 -0500
Message-ID: <3A5BEA90.D3B68DCD@alvie.com>
Date: Wed, 10 Jan 2001 04:52:32 +0000
From: Alvaro Lopes <alvieboy@alvie.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel (2.4.0) lock-up in "write" (using PTS).
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

This is somewhat odd, but I seemed to have found some kind of bug in
2.4.0. I  tested the same program in 2.2.17 and it run perfectly.

So, here goes the description:

2.4.0 Kernel hangs up when I do the following stuff:

	* Create a new PTY using openpty();
	* Fork using forkpty. Now, the child process does this:
		- Set the fd 0 line discipline to PPP;
		- tries infinitely to read the standard input.

	The parent process sets the line discipline of the master PTY fd to PPP
also, and then writes to it.


When I say it hangs up I really mean it. Not even the SYSRQ works.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
