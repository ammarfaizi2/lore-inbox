Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRBSBkq>; Sun, 18 Feb 2001 20:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129766AbRBSBkf>; Sun, 18 Feb 2001 20:40:35 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55822 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129460AbRBSBk3>; Sun, 18 Feb 2001 20:40:29 -0500
Subject: Re: [PROBLEM] 2.4.1 can't mount ext2 CD-ROM
To: axboe@suse.de (Jens Axboe)
Date: Mon, 19 Feb 2001 01:40:16 +0000 (GMT)
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, zzed@cyberdude.com,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <20010218201639.A6593@suse.de> from "Jens Axboe" at Feb 18, 2001 08:16:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UfJK-00026X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So put 0 and sure anyone can submit I/O on the size that they want.
> Now the driver has to support padding reads, or gathering data to do
> a complete block write. This is silly. Sr should support 512b transfers
> just fine, but only because I added the necessary _hacks_ to support
> it. sd doesn't right now for instance.

It is silly to be in the block layer, it is silly to be in each file system.
Perhaps it belongs in the block queueing/handling code or the caches

But it has to go somewhere, and 2.4 right now is unusable on two of my boxes
with M/O drives.

