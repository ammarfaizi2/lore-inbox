Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUAHKe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbUAHKe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:34:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:64390 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264272AbUAHKeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:34:22 -0500
Date: Thu, 8 Jan 2004 02:33:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: nathans@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: Performance drop 2.6.0-test7 -> 2.6.1-rc2
Message-Id: <20040108023356.00db9dec.akpm@osdl.org>
In-Reply-To: <20040108112547.G20265@fi.muni.cz>
References: <20040107023042.710ebff3.akpm@osdl.org>
	<20040107215240.GA768@frodo>
	<20040108105427.E20265@fi.muni.cz>
	<20040108021637.15d1b33a.akpm@osdl.org>
	<20040108112547.G20265@fi.muni.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@informatics.muni.cz> wrote:
>
> Andrew Morton wrote:
> : Jan Kasprzak <kas@informatics.muni.cz> wrote:
> : >  - this is reliable: repeated boot back to 2.6.1-rc2 makes the problem
> : >  	appear again (high load, system slow has hell), booting back
> : >  	to -test7 makes it disappear.
> : 
> : Is the CPU load higher than normal?  Excluding I/O wait?
> 
> 	No, ~30% system is pretty standard for this server. I have looked
> just now (2.6.0-test7), and I have 33% system, about 50% nice,
> and the rest is user, iowait and idle. Under 2.6.1-rc2 it was about 30%
> system and the rest iowait, with small amount of nice and user.
> However, the load may be different. It is hard to have any kind of
> "fixed" load when you serve data over FTP, HTTP, rsync and do some
> other minor tasks (updatedb, current/up2date server, ...).

OK.

> 	Do you still want the system profiling info?

Nope.

It would be interesting to run some simple benchmarks (dbench, iozone,
tiobench, etc) on a relatively idle system.

After that, it'd be a matter of searching through kernel versions, which
you presumably cannot do.  Or eliminating device mapper from the picture,
which is also presumably not an option.


Have you run `hdparm' to check that all those disks have DMA enabled?  I
guess they have.


