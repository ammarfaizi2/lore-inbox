Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262482AbSKCVFj>; Sun, 3 Nov 2002 16:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSKCVFj>; Sun, 3 Nov 2002 16:05:39 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:54926 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262482AbSKCVFh>; Sun, 3 Nov 2002 16:05:37 -0500
Subject: Re: swsusp: don't eat ide disks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: benh@kernel.crashing.org, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021103201251.GE27271@elf.ucw.cz>
References: <200211022006.gA2K6XW08545@devserv.devel.redhat.com>
	<20021103145735.14872@smtp.wanadoo.fr>
	<1036340733.29642.41.camel@irongate.swansea.linux.org.uk> 
	<20021103201251.GE27271@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 21:33:27 +0000
Message-Id: <1036359207.30629.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 20:12, Pavel Machek wrote:
> > 		Throw out the pages we can evict
> 
> ...DMA from disk may be still running here...

Only if a request is still active and therfore the queue is not quiesced

> ...and at resume you find out that your memory is not consistent
> because DMA was still running when you were doing copy.

I can see how that can be a problem for some other things but not block
devices.

