Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTKYNip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 08:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbTKYNio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 08:38:44 -0500
Received: from mail.it.helsinki.fi ([128.214.205.39]:29085 "EHLO
	mail.it.helsinki.fi") by vger.kernel.org with ESMTP id S262591AbTKYNim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 08:38:42 -0500
Date: Tue, 25 Nov 2003 15:38:37 +0200 (EET)
From: Mikael Johansson <mpjohans@pcu.helsinki.fi>
X-X-Sender: mpjohans@soul.helsinki.fi
To: Joshua Schmidlkofer <kernel@pacrimopen.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Superior disk perf. of 2.4.20-ac (Was: RAID-0 read perf. decrease
 after 2.4.20)
In-Reply-To: <1069736477.1552.11.camel@menion.home>
Message-ID: <Pine.OSF.4.58.0311251526220.5161@soul.helsinki.fi>
References: <20031124100534.24941.qmail@web13902.mail.yahoo.com>
 <1069736477.1552.11.camel@menion.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hell Joshua and All!

On Mon, 24 Nov 2003, Joshua Schmidlkofer wrote:

> > >Has anyone else experienced a drastic drop in read performance on
> > >software
> > >RAID-0 with post 2.4.20 kernels? We have a few Athlon XP's here at our

> And this isn't the read-ahead size change thing?

When did this change take place? It would be easy to test then. I did some
more tests on the weekend and found that this isn't RAID related; also
normal single disk access is much faster on the 2.4.20-ac's than on other
recent kernels. Just to summarise, the disk speed on one of the Athlon
XP's (2GHz, 1.5 GB RAM, 2*160 GB Maxtor 6Y080L0) according to bonnie++:

RAID-0		VIA	write	read
2.4.19		none	10,000	  9,000
2.4.20		3.35	73,000	 88,000
2.4.20-ac1	3.35-ac	70,000	135,000
2.4.20-ac2 	3.35-ac	71,000	140,000
2.4.21-pre1     3.35-ac 71,000	 79,000
2.4.21-pre3	3.35-ac 71,000	 79,000
2.4.23-rc3	3.37	65,000	 82,000

single disk
2.4.20-ac2	3.35-ac	55,000	 74,000
2.4.23-rc3	3.37	54,000	 48,000

So the single disk read performance of 2.4.20-ac2 is as fast as a
double RAID-0 array of other kernels.

Have a nice day,
    Mikael J.
    http://www.helsinki.fi/~mpjohans/
