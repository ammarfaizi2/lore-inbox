Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272049AbTGYMsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 08:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272050AbTGYMsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 08:48:51 -0400
Received: from www.wireboard.com ([216.151.155.101]:23199 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id S272049AbTGYMst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 08:48:49 -0400
To: Andrew Barton <andrevv@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forkpty with streams
References: <1059089316.8596.14.camel@localhost>
From: Doug McNaught <doug@mcnaught.org>
Date: 25 Jul 2003 09:02:53 -0400
In-Reply-To: Andrew Barton's message of "24 Jul 2003 23:28:36 +0000"
Message-ID: <m3el0esqrm.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Barton <andrevv@users.sourceforge.net> writes:

> I've got the 2.4 kernel, and I'm trying to use the forkpty() system call
> with the standard I/O stream functions. The calls to forkpty() and
> fdopen() and fprintf() all return successfully, but the data never seems
> to get to the child process. In this simplified example, I am trying to
> open a shell in a pseudo terminal and then send it the string "exit\n"
> and then wait for it to die. But the shell apparently never sees the
> "exit\n", and the parent waits forever.

forkpty() is not a system call.  This is more likely to be a glibc
issue or a problem with your code.  You might consider running your
test under 'strace' to see what is happening under the covers.

-Doug
