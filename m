Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267790AbRGUTUI>; Sat, 21 Jul 2001 15:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267792AbRGUTT6>; Sat, 21 Jul 2001 15:19:58 -0400
Received: from L0190P28.dipool.highway.telekom.at ([62.46.87.188]:62337 "EHLO
	mannix") by vger.kernel.org with ESMTP id <S267790AbRGUTTu>;
	Sat, 21 Jul 2001 15:19:50 -0400
Date: Sat, 21 Jul 2001 21:18:31 +0200
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Daniel Phillips <phillips@bonn-fries.net>, cw@f00f.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010721211831.A9471@aon.at>
In-Reply-To: <200107160108.f6G18fJ299454@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200107160108.f6G18fJ299454@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.18i
From: Alexander Griesser <tuxx@aon.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 15, 2001 at 09:08:41PM -0400, you wrote:
> > The only requirement here is that the checksum be correct.  And sure,
> > that's not a hard guarantee because, on average, you will get a good
> > checksum for bad data once every 4 billion power events that mess up
> > the final superblock transfer.  Let me see, if that happens once a year,
> In a tree-structured filesystem, checksums on everything would only
> cost you space similar to the number of pointers you have. Whenever
> a non-leaf node points to a child, it can hold a checksum for that
> child as well.
> This gives a very reliable way to spot filesystem errors, including
> corrupt data blocks.

Hmm, maybe this is crap, but:
If the checksum-calculation for one node fails, wouldn't that mean, that
the data in this node, is not to be trusted? therefore also the checksum
of this node could be corrupted and so the node, 2 hops away, can't be
validated with 100% certitude...

regards, alexx
-- 
|   .-.   | Alexander Griesser <tuxx@aon.at> -=- ICQ:63180135 |  .''`. |
|   /v\   |  http://www.tuxx-home.at -=- Linux Version 2.4.7  | : :' : |
| /(   )\ |  FAQ zu at.linux:  http://alfie.ist.org/LinuxFAQ  | `. `'  |
|  ^^ ^^  `---------------------------------------------------´   `-   |
