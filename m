Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUANAG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbUANAGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:06:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:17317 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266281AbUANAFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:05:22 -0500
Date: Tue, 13 Jan 2004 16:06:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Haakon Riiser <hakonrk@ulrik.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Message-Id: <20040113160637.71d63de1.akpm@osdl.org>
In-Reply-To: <20040113234611.GA558@s.chello.no>
References: <20040113210923.GA955@s.chello.no>
	<20040113135152.3ed26b85.akpm@osdl.org>
	<20040113232624.GA302@s.chello.no>
	<20040113234611.GA558@s.chello.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haakon Riiser <hakonrk@ulrik.uio.no> wrote:
>
> > Output from time:
> > 
> >   real    0m0.309s
> >   user    0m0.011s
> >   sys     0m0.004s
> 
> Just wanted to comment on my own data, since I just noticed it myself:
> 
> The output from time indicates that the system is _not_ using CPU
> while delaying, so you might wonder why I said it did.  The reason
> is that I'm using an AfterStep applet (ascpu) to monitor CPU usage,
> and it appeared to work fine in 2.6.  Now, I see that there are
> differences:  For example, another problem I encountered while
> upgrading to 2.6 was that disk intensive jobs, such as updating
> the slocate database, made ascpu report 100% CPU usage.  I just
> ran top (procps 2.0.16) beside it, and it reported approximately
> 10% CPU usage, which is no more than 2.4 used.

2.6 has finer-grained cpu utilisation accounting; probably ascpu is
accidentally lumping I/O wait into system time.

Still, some of those delays seem excessive and if you indeed are seeing
longer runtimes than with 2.4, something is up.

