Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbTJTH0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTJTH0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:26:42 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:14720 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262418AbTJTHYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:24:14 -0400
Date: Mon, 20 Oct 2003 08:24:48 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310200724.h9K7Omki000376@81-2-122-30.bradfords.org.uk>
To: Pavel Machek <pavel@suse.cz>, William Lee Irwin III <wli@holomorphy.com>,
       Hans Reiser <reiser@namesys.com>, Larry McVoy <lm@bitmover.com>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Pavel Machek <pavel@ucw.cz>,
       Justin Cormack <justin@street-vision.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Vitaly Fertman <vitaly@namesys.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       axboe@suse.de
In-Reply-To: <20031019200105.GD354@elf.ucw.cz>
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60>
 <20031019041553.GA25372@work.bitmover.com>
 <3F924660.4040405@namesys.com>
 <20031019083551.GA1108@holomorphy.com>
 <20031019200105.GD354@elf.ucw.cz>
Subject: Re: Blockbusting news, results are in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think the fs driver layer might be the wrong thing too; maybe it'd be
> > best to do the CRC and/or checksumming at the block layer?
> 
> I think that's best place.

Yes, because you can then use it on ST-506 disks if you really want
to, and never see a bad block at the filesystem level.  It also means
that people with drives that do defect management to their
satisfaction don't need the overhead of the defect management in
software layer, however small it may be.

John.
