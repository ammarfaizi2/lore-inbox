Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTJUU2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTJUU2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:28:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:49798 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263357AbTJUU2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:28:15 -0400
Date: Tue, 21 Oct 2003 16:31:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results are in 
In-Reply-To: <200310212021.h9LKLQK3009397@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.53.0310211628130.20041@chaos>
References: <175701c397e6$b36e5310$24ee4ca5@DIAMONDLX60>
 <20031021193128.GA18618@helium.inexs.com>            <Pine.LNX.4.53.0310211558500.19942@chaos>
 <200310212021.h9LKLQK3009397@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003 Valdis.Kletnieks@vt.edu wrote:

> On Tue, 21 Oct 2003 16:05:15 EDT, "Richard B. Johnson" said:
>
> > If the respondent wants them isolated into a "BADBLOCKS" file,
> > he can make a utility to do that. It's really quite easy because
> > you can raw-read disks under Linux, plus there is already
> > the `badblocks` program that will locate them.
>
> Yes, it's trivially easy to figure out that block 193453 on /dev/hdb is bad.
> It's even not too bad to map that to an offset on /dev/hdb4.  Even if you're
> using LVM or DM to map stuff, it's still attackable.  But how do you guarantee
> that block 193453 gets allocated to your badblocks file and not to some other
> file that just tried to extend itself by 32K?
>
>

You repair file-systems when they are not mounted. Also, the
source of an old version of e2fsprogs has a "defrag" utility
that could be used as a sample of how to create a file that
owns the bad blocks you find.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


