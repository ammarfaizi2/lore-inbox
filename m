Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTFJR6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 13:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTFJR6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 13:58:17 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13760 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263775AbTFJR6P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 13:58:15 -0400
Date: Tue, 10 Jun 2003 20:11:22 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Nathan Conrad <conrad@bungled.net>
cc: Oleg Drokin <green@namesys.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 / reiserfs data corruption, 2.5-bk
In-Reply-To: <20030610214436.GA6719@bungled.net>
Message-ID: <Pine.SOL.4.30.0306102001430.24343-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jun 2003, Nathan Conrad wrote:

> I've been noticing a similar problem on my laptop. This may, or may
> not be related, but it did start somewhere within the past week (maybe
> the IDE taskfile conversion???, to throw out a guess). I wonder if

wrt taskfile conversion, if you are using DMA on your IDE disks,
there shouldn't be any change in behaviour.

I will prepare a patch adding old crap and making it selectable
(default will be taskfile, if you go into problems you can check
with old code) to easy spotting possible taskfile problems
and allowing quick judging - taskfile guilty/not guilty.

--
Bartlomiej

> Dave Jones is using IDE or SCSI. CONFIG_SMP and CONFIG_PREEMPT are
> disabled on my machine (Sony Vaio PCG-FXA49 laptop, Athlon4). I'm
> compiling the kernel with gcc 3.3 (Debian version).
>
> Anyway, certain directories get locked up on occasion and when I try
> to execute 'ls' or read from the directory, the process gets into a
> locked up state; ^C does not work to kill the process. The only way to
> make a directory "readable" is to restart the machine. I have not
> noticed any FS corruption, just the lack of being able to enter the
> directory.
>
>  At the same time, a kernel bug will be displayed:

<...>

