Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314684AbSETJWD>; Mon, 20 May 2002 05:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315272AbSETJWD>; Mon, 20 May 2002 05:22:03 -0400
Received: from co239024-a.almel1.ov.nl.home.com ([217.120.226.100]:12428 "EHLO
	quinten.nl") by vger.kernel.org with ESMTP id <S314684AbSETJWC>;
	Mon, 20 May 2002 05:22:02 -0400
Date: Mon, 20 May 2002 11:21:26 +0200 (CEST)
From: Aschwin Marsman - aYniK Software Solutions <a.marsman@aYniK.com>
X-X-Sender: marsman@quinten.nl
To: Neil Aggarwal <neil@JAMMConsulting.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug in RedHat 7.3 -- Assertion failure in
 journal_commit_transaction() at commit.c:535: "buffer_jdirty(bh)"
In-Reply-To: <ENEBKGGOKDOEALIKAJMBOEIPCGAA.neil@JAMMConsulting.com>
Message-ID: <Pine.LNX.4.44.0205201117150.2034-100000@quinten.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 May 2002, Neil Aggarwal wrote:

> Hello:
> 
> My RedHat 7.3 machine just locked up and I could not reboot it.  I had
> to punch the reset button.

It looks like you didn't install the kernel update. Below is a piece of 
my RH 7.3 article:

Kernel panic on SMP systems with ext3 file systems is now fixed. 
A few bugs, including one in ext3 that could cause a kernel panic
on SMP systems, are fixed in a kernel errata.
If you experienced the filesystem panic, you are recommended to
check filesystem consistency.  This bug will show up as one of
"kernel BUG at journal.c:406" or "kernel BUG at commit.c:535"
(The check is done in two places in the source code, and either
of them might show up.)
To force the filesystem check, log in as root, run
touch /forcefsck
and then reboot the system.  It will check all the filesystems
after rebooting.  This needs to be done only once after you
experience the panic.  

The whole article can be found at:
http://www.aynik.com/articles/20020507.1.php

> Has anyone seen this?  Is there a way to fix it?

The update should solve your problem.

> Thanks,
> 	Neil.
 
Kind regards,
 
Aschwin Marsman
 
--
aYniK Software Solutions - all You need is Knowledge
Bedrijvenpark Twente 305 - NL-7602 KL Almelo - the Netherlands
P.O. box 134             - NL-7600 AC Almelo - the Netherlands
telephone: +31 (0)546-581400 fax: +31 (0)546-581401
a.marsman@aYniK.com        http://www.aYniK.com
aschwin@marsman.org        http://www.marsman.org

