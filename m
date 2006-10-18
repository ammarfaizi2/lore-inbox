Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWJRRzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWJRRzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWJRRzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:55:10 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:2491 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751521AbWJRRzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:55:08 -0400
Date: Wed, 18 Oct 2006 10:56:34 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fs/Kconfig question regarding CONFIG_BLOCK
Message-Id: <20061018105634.2f8cb629.randy.dunlap@oracle.com>
In-Reply-To: <20061018070922.GB24452@kernel.dk>
References: <Pine.LNX.4.61.0610172041190.30104@yvahk01.tjqt.qr>
	<200610171857.k9HIvq1M009488@turing-police.cc.vt.edu>
	<Pine.LNX.4.61.0610172119420.928@yvahk01.tjqt.qr>
	<20061017193645.GM7854@kernel.dk>
	<Pine.LNX.4.61.0610172146450.928@yvahk01.tjqt.qr>
	<20061018070922.GB24452@kernel.dk>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 09:09:22 +0200 Jens Axboe wrote:

> On Tue, Oct 17 2006, Jan Engelhardt wrote:
> > >> Never mind, I see that some filesystems have 'depends on BLOCK' instead 
> > >> of being wrapped into if BLOCK. Not really consistent but whatever.
> > >
> > >Feel free to send in patches that make things more consistent.
> > 
> > How would you like things? if BLOCK or depends on BLOCK?
> 
> Well, if you can hide an entire block with if BLOCK, then that would be
> preferred. Otherwise depends on BLOCK.
> 
> > Does menuconfig/oldconfig/etc. parse the whole config structure faster 
> > it it done either way?
> 
> I'd be surprised if if BLOCK wasn't faster over, say, 10 depends on
> BLOCK.

Jens,
Has anyone looked at what BLOCK=n does to mm/page-writeback.c ?
It calls blk_congestion_end(), which isn't there.

mm/built-in.o: In function `writeback_congestion_end':
(.text.writeback_congestion_end+0xc): undefined reference to `blk_congestion_end'
make: *** [.tmp_vmlinux1] Error 1
Command exited with non-zero status 2


---
~Randy
