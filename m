Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278798AbRJZRwU>; Fri, 26 Oct 2001 13:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278805AbRJZRwK>; Fri, 26 Oct 2001 13:52:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30220 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278798AbRJZRv6>; Fri, 26 Oct 2001 13:51:58 -0400
Subject: Re: Linux 2.4.13-ac1
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 26 Oct 2001 18:54:00 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        cswingle@iarc.uaf.edu (Christopher S. Swingley),
        linux-kernel@vger.kernel.org
In-Reply-To: <20011026194301.M30905@athlon.random> from "Andrea Arcangeli" at Oct 26, 2001 07:43:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xBBA-0000pp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> simply because the <2.4.10 buffer cache layer wasn't able to do proper
> readahead on the blkdev. Now we do readahead properly and so in turn
> the the lack of media-change trust of the vfs shows up. So as far I can
> tell the right fix have no influence on the blkdev in pagecache, but it
> only consists in resurrecting the media-change detection with a
> per-device bitflag whitelist. I cannot see other source of stalls across
> a close/open cycle.

I'm not currently sure if the impact is from the cost of the page cache
flushing or the invalidate/re-read it triggers. There probably are two or
three seeks on the DVD if the data is invalidated so that would make sense.

Alan
