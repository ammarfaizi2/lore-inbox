Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268998AbRHBPLk>; Thu, 2 Aug 2001 11:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268992AbRHBPLa>; Thu, 2 Aug 2001 11:11:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25362 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268986AbRHBPLV>; Thu, 2 Aug 2001 11:11:21 -0400
Subject: Re: [RFT] Support for ~2144 SCSI discs
To: dougg@torque.net (Douglas Gilbert)
Date: Thu, 2 Aug 2001 16:08:03 +0100 (BST)
Cc: rgooch@ras.ucalgary.ca (Richard Gooch), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <no.id> from "Douglas Gilbert" at Jul 31, 2001 09:05:43 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SK4x-0000qB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've seen GFP_KERNEL take 10 minutes in lk 2.4.6 . The 
> mm gets tweaked pretty often so it is difficult to know 
> exactly how it will react when memory is tight. A time 
> bound would be useful on GFP_KERNEL.

kmalloc with GFP_KERNEL has a 128K limit which avoids the bizarre behaviour
you get when you abuse get_free_pages.

