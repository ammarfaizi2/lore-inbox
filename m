Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423323AbWJSMUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423323AbWJSMUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423325AbWJSMUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:20:15 -0400
Received: from brick.kernel.dk ([62.242.22.158]:15189 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1423323AbWJSMUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:20:14 -0400
Date: Thu, 19 Oct 2006 14:20:57 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fs/Kconfig question regarding CONFIG_BLOCK
Message-ID: <20061019122056.GI30700@kernel.dk>
References: <Pine.LNX.4.61.0610172041190.30104@yvahk01.tjqt.qr> <200610171857.k9HIvq1M009488@turing-police.cc.vt.edu> <Pine.LNX.4.61.0610172119420.928@yvahk01.tjqt.qr> <20061017193645.GM7854@kernel.dk> <Pine.LNX.4.61.0610172146450.928@yvahk01.tjqt.qr> <20061018070922.GB24452@kernel.dk> <20061018105634.2f8cb629.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018105634.2f8cb629.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18 2006, Randy Dunlap wrote:
> On Wed, 18 Oct 2006 09:09:22 +0200 Jens Axboe wrote:
> 
> > On Tue, Oct 17 2006, Jan Engelhardt wrote:
> > > >> Never mind, I see that some filesystems have 'depends on BLOCK' instead 
> > > >> of being wrapped into if BLOCK. Not really consistent but whatever.
> > > >
> > > >Feel free to send in patches that make things more consistent.
> > > 
> > > How would you like things? if BLOCK or depends on BLOCK?
> > 
> > Well, if you can hide an entire block with if BLOCK, then that would be
> > preferred. Otherwise depends on BLOCK.
> > 
> > > Does menuconfig/oldconfig/etc. parse the whole config structure faster 
> > > it it done either way?
> > 
> > I'd be surprised if if BLOCK wasn't faster over, say, 10 depends on
> > BLOCK.
> 
> Jens,
> Has anyone looked at what BLOCK=n does to mm/page-writeback.c ?
> It calls blk_congestion_end(), which isn't there.
> 
> mm/built-in.o: In function `writeback_congestion_end':
> (.text.writeback_congestion_end+0xc): undefined reference to `blk_congestion_end'
> make: *** [.tmp_vmlinux1] Error 1
> Command exited with non-zero status 2

Yeah currently known, with Andrew's latest we should be getting closer.

-- 
Jens Axboe

