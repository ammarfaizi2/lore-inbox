Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266055AbUAMXqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUAMXqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:46:18 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:3872 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S266055AbUAMXqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:46:13 -0500
Date: Wed, 14 Jan 2004 00:46:11 +0100
From: Haakon Riiser <hakonrk@ulrik.uio.no>
To: linux-kernel@vger.kernel.org
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Message-ID: <20040113234611.GA558@s.chello.no>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040113210923.GA955@s.chello.no> <20040113135152.3ed26b85.akpm@osdl.org> <20040113232624.GA302@s.chello.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113232624.GA302@s.chello.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Output from time:
> 
>   real    0m0.309s
>   user    0m0.011s
>   sys     0m0.004s

Just wanted to comment on my own data, since I just noticed it myself:

The output from time indicates that the system is _not_ using CPU
while delaying, so you might wonder why I said it did.  The reason
is that I'm using an AfterStep applet (ascpu) to monitor CPU usage,
and it appeared to work fine in 2.6.  Now, I see that there are
differences:  For example, another problem I encountered while
upgrading to 2.6 was that disk intensive jobs, such as updating
the slocate database, made ascpu report 100% CPU usage.  I just
ran top (procps 2.0.16) beside it, and it reported approximately
10% CPU usage, which is no more than 2.4 used.

I don't know how ascpu measures CPU usage, but it's interesting
that it appears to work fine for the most part, while giving
_completely_ different results from all other programs (e.g.,
time, top, ps) in the write-delay case, and other disk related
activities.

(For the record, I've never seen ascpu's results differ from
top's under Linux 2.4.x.)

-- 
 Haakon
