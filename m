Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTGMVz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 17:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbTGMVz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 17:55:29 -0400
Received: from nmh.informatik.uni-bremen.de ([134.102.224.3]:62351 "EHLO
	nmh.informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S264186AbTGMVz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 17:55:28 -0400
To: linux-kernel@vger.kernel.org
Cc: "Barry K. Nathan" <barryn@pobox.com>
From: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>
Subject: Re: [BUG] 100% reproducible oops on ATAPI CD-ROM I/O error, 2.5.75
In-Reply-To: <20030711093335.GC2860@ip68-4-255-84.oc.oc.cox.net>
References: <20030711093335.GC2860@ip68-4-255-84.oc.oc.cox.net>
Date: Mon, 14 Jul 2003 00:10:08 +0200
Message-Id: <E19bp2m-0006gf-00@regenbogen.informatik.uni-bremen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In stuga.ml.linux.kernel, you wrote:
> I added this as a comment to bugme.osdl.org bug 878, but here's a
> cleaned-up version of the reproduction instructions:
> 
> 5. readcd dev=/dev/hdc f=/dev/null
> (readcd chokes near the end of the CD, tries reading again, and oopses
> the kernel)

With kernel 2.5.75-bk3 it doesn't oops neither on my CD-RW, nor on
my CD-ROM. I guess that's related to ChangeSet@1.486 from Jens Axboe
   [PATCH] Fix IDE-CD command failure re-play
   
Does anyone have an explanation why cdrecord fails to write the last
sector properly? Is this a kernel issue or a bug in cdrecord?
I'm using cdrtools 2.01a15.
