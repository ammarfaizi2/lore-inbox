Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131289AbRCRXdu>; Sun, 18 Mar 2001 18:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131292AbRCRXdk>; Sun, 18 Mar 2001 18:33:40 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:23049
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131289AbRCRXd0>; Sun, 18 Mar 2001 18:33:26 -0500
Date: Sun, 18 Mar 2001 15:32:17 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jens Axboe <axboe@suse.de>, Paul Gortmaker <p_gortmaker@yahoo.com>,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] off-by-1 error in ide-probe (2.4.x)
In-Reply-To: <Pine.LNX.4.31.0103181527140.2798-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10103181529290.17416-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001, Linus Torvalds wrote:

> 
> 
> On Sun, 18 Mar 2001, Jens Axboe wrote:
> >
> > The 256 is _not_ a bug in the driver, it's more likely a bug in your
> > drive. 256 is a perfectly legal transfer size. That said, maybe it is
> > a good idea to leave it at 255 just for safety on drives not handling
> > 0 sectors == 128kB transfer.
> 
> Agreed. That would be a trivially easy bug in the firmware, limiting to
> 255 sectors seems safer.

Guys which side of the counter is the decrementer?

Telling the drive to transfer 256 sectors in PIO is filling the
sector_count register with '0' == 'zero'.

As long as 255 == 255 and 0 == 256 for total sectors to transfer all is
cool.


Andre Hedrick
Linux ATA Development

