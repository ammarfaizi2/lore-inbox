Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWJQTXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWJQTXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWJQTXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:23:55 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:24736 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751180AbWJQTXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:23:54 -0400
Date: Tue, 17 Oct 2006 21:21:44 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Valdis.Kletnieks@vt.edu
cc: jens.axboe@oracle.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fs/Kconfig question regarding CONFIG_BLOCK
In-Reply-To: <200610171857.k9HIvq1M009488@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.61.0610172119420.928@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610172041190.30104@yvahk01.tjqt.qr>
 <200610171857.k9HIvq1M009488@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> fs/Kconfig has:
>> 
>> if BLOCK
>> menu "DOS/FAT/NT Filesystems"
>
>> Why is it wrapped into BLOCK, or, why are all of the other filesystems 
>> which require a block device?
>
>Some filesystems (such as /proc, /sys, and so on - basicaly, the "pseudo" file
>systems) are able to stand by themselves.  Filesystems that read actual blocks
>of data off actual media will require the services of the block layer to do
>that.  So if you've built a tiny embedded kernel that doesn't include the block
>layer, you can't read those sorts of filesystems....

Never mind, I see that some filesystems have 'depends on BLOCK' instead 
of being wrapped into if BLOCK. Not really consistent but whatever.


	-`J'
-- 
