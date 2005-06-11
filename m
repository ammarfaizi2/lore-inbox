Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVFKJav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVFKJav (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 05:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVFKJaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 05:30:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261659AbVFKJaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 05:30:10 -0400
Date: Sat, 11 Jun 2005 02:29:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: spaminos-ker@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
Message-Id: <20050611022959.3954ff6b.akpm@osdl.org>
In-Reply-To: <20050610225443.75162.qmail@web30704.mail.mud.yahoo.com>
References: <20050610225443.75162.qmail@web30704.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<spaminos-ker@yahoo.com> wrote:
>
> Hello, I am running into a very bad problem on one of my production servers.
> 
>  * the config
>  Linux Fedora core 3 latest everything, kernel 2.6.11-1.14_FC3
>  AMD Opteron 2 GHz, 1 G RAM, 80 GB Hard drive (IDE, Western Digital)
> 
>  I have a log processor running in the background, it's using sqlite for storing
>  the information it finds in the logs. It takes a few hours to complete a run.
>  It's clearly I/O bound (SleepAVG = 98%, according to /proc/pid/status).
>  I have to use the cfq scheduler because it's the only scheduler that is fair
>  between processes (or should be, keep reading).
> 
>  * the problem
>  Now, after an hour or so of processing, the machine becomes very unresponsive
>  when trying to do new disk operations. I say new because existing processes
>  that stream data to disk don't seem to suffer so much.

It might be useful to test 2.6.12-rc6-mm1 - it has a substantially
rewritten CFQ implementation.
