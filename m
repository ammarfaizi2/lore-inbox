Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSKDUY5>; Mon, 4 Nov 2002 15:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262743AbSKDUY4>; Mon, 4 Nov 2002 15:24:56 -0500
Received: from kim.it.uu.se ([130.238.12.178]:43720 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S262730AbSKDUYz>;
	Mon, 4 Nov 2002 15:24:55 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15814.55581.459295.2217@kim.it.uu.se>
Date: Mon, 4 Nov 2002 21:31:25 +0100
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] performance counters 3.1 for 2.5.45 [4/4]: kernel
	changes
In-Reply-To: <1036440740.18668.5.camel@dell_ss3.pdx.osdl.net>
References: <200210312310.AAA07615@kim.it.uu.se>
	<1036440740.18668.5.camel@dell_ss3.pdx.osdl.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger writes:
 > On Thu, 2002-10-31 at 15:10, Mikael Pettersson wrote:
 > > This is part 4 of 4 of perfctr-3.1 for the 2.5.45 kernel:
 > > kernel changes to integrate the low and high-level drivers.
...
 > 
 > Rather than adding yet another system call, shouldn't this be done by
 > extending the cpu part of sysfs (or /proc)?

Why?
ptrace() is a system call
fork() is a system call
write() is a system call
other arch's performance counter interfaces are system calls
...

 > It looks like the operations in sys_vperfctr could be easily mapped to a
 > RAM based file system.  As it stands it reminds me of one of the old DEC
 > graphic libraries with one API entry for all the operations, and 65
 > different flag values.

There are about half a dozen operations, not 65. I could use 6 system calls,
no problem, but as long as Linus is silent about this I have no reason to
change it speculatively in random directions.

/Mikael
