Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313737AbSDPQI0>; Tue, 16 Apr 2002 12:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313739AbSDPQGd>; Tue, 16 Apr 2002 12:06:33 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:1255 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S313744AbSDPQFk>; Tue, 16 Apr 2002 12:05:40 -0400
Date: Tue, 16 Apr 2002 17:05:38 +0100 (BST)
From: Matt Bernstein <mb/oops@dcs.qmul.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.4.18-pre7-ac3 ext3
In-Reply-To: <Pine.LNX.4.44.0204161340180.28762-100000@nick.dcs.qmul.ac.uk>
Message-ID: <Pine.LNX.4.44.0204161703450.28762-100000@nick.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solved by Stephen Tweedie.

Don't live dump your filesystems :-/ [the pot calling kettle black]

At 13:43 +0100 Matt Bernstein wrote:

>I had the following spat out by syslog on my (2.4.18-pre7-ac3) mailer /
>web server:
>
>Assertion failure in do_get_write_access() at transaction.c:611: "!(((jh2bh(jh))->b_state & (1UL << BH_Lock)) != 0)"
>
>One of its partitions froze hard--I've rebooted it, and I have an oops
>which the BUG() triggered. Here's the trace. I hope it can shed some
>light.. (the machine is a UP Athlon, everything and its daughter a module,
>the most notable possibly being nfsd, gdth, e100 (1.6.29), jbd, ext3)

