Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTDTNn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 09:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTDTNn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 09:43:56 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2176 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263578AbTDTNnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 09:43:55 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304201359.h3KDx0q5000260@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Sun, 20 Apr 2003 14:59:00 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20030419190046.6566ed18.skraw@ithnet.com> from "Stephan von Krawczynski" at Apr 19, 2003 07:00:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, you mean active error-recovery on reading. My basic point is the writing
> case. A simple handling of write-errors from the drivers level and a retry to
> write on a different location could help a lot I guess.

A filesystem is not the place for that - it could either be done at a
lower level, like I suggested in a separate post, or at a much higher
level - E.G. a database which encounters a write error could dump it's
entire contents to a tape drive, shuts down, and page an
administrator, on the basis that the write error indicated impending
drive failiure.

> > Buy IDE disks in pairs use md1, and remember to continually send the
> > hosed ones back to the vendor/shop (and if they keep appearing DOA to
> > your local trading standards/fair trading type bodies).
> 
> Just to give some numbers: from 25 disk I bought during last half
> year 16 have gone dead within the first month. This is
> ridiculous. Of course they are all returned and guarantee-replaced,
> but it gets on ones nerves to continously replace disks, the rate
> could be lowered if one could use them at least 4 months (or upto a
> deadline number of bad blocks mapped by the fs - still guarantee but
> fewer replacement cycles).

Are you using the disks within their operational limits?  Are you sure
they are not overheating and/or being run 24/7 when they are not
intended to be?

John.
