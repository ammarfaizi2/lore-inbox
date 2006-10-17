Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWJQTgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWJQTgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWJQTgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:36:09 -0400
Received: from brick.kernel.dk ([62.242.22.158]:64796 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751192AbWJQTgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:36:08 -0400
Date: Tue, 17 Oct 2006 21:36:45 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fs/Kconfig question regarding CONFIG_BLOCK
Message-ID: <20061017193645.GM7854@kernel.dk>
References: <Pine.LNX.4.61.0610172041190.30104@yvahk01.tjqt.qr> <200610171857.k9HIvq1M009488@turing-police.cc.vt.edu> <Pine.LNX.4.61.0610172119420.928@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610172119420.928@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17 2006, Jan Engelhardt wrote:
> 
> >> fs/Kconfig has:
> >> 
> >> if BLOCK
> >> menu "DOS/FAT/NT Filesystems"
> >
> >> Why is it wrapped into BLOCK, or, why are all of the other filesystems 
> >> which require a block device?
> >
> >Some filesystems (such as /proc, /sys, and so on - basicaly, the "pseudo" file
> >systems) are able to stand by themselves.  Filesystems that read actual blocks
> >of data off actual media will require the services of the block layer to do
> >that.  So if you've built a tiny embedded kernel that doesn't include the block
> >layer, you can't read those sorts of filesystems....
> 
> Never mind, I see that some filesystems have 'depends on BLOCK' instead 
> of being wrapped into if BLOCK. Not really consistent but whatever.

Feel free to send in patches that make things more consistent.

-- 
Jens Axboe

