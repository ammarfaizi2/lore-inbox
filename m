Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRCSATn>; Sun, 18 Mar 2001 19:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131312AbRCSATe>; Sun, 18 Mar 2001 19:19:34 -0500
Received: from hera.cwi.nl ([192.16.191.8]:16812 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131307AbRCSATX>;
	Sun, 18 Mar 2001 19:19:23 -0500
Date: Mon, 19 Mar 2001 01:18:30 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103190018.BAA09516.aeb@vlet.cwi.nl>
To: axboe@suse.de, torvalds@transmeta.com
Subject: Re: [PATCH] off-by-1 error in ide-probe (2.4.x)
Cc: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org,
        linux-kernel@vger.kernel.org, p_gortmaker@yahoo.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    On Sun, 18 Mar 2001, Jens Axboe wrote:
    >
    > The 256 is _not_ a bug in the driver, it's more likely a bug in your
    > drive. 256 is a perfectly legal transfer size. That said, maybe it is
    > a good idea to leave it at 255 just for safety on drives not handling
    > 0 sectors == 128kB transfer.

    Agreed. That would be a trivially easy bug in the firmware, limiting to
    255 sectors seems safer.

            Linus

Yes, possibly.
I checked old standards, and see that "0 means 256 as a sector count"
is already in ATA-1.

Is there any evidence that other people have been hit by this?
Unfortunately, the
 "status error: status=0x58 { DriveReady SeekComplete DataRequest }"
is reported frequently these days, and has many causes.
In old reports it is rare. (E.g. none in lk for 1997.)

Paul: is there only one disk that you can make fail this way?

Andries
