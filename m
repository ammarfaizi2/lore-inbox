Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbTC0Xfd>; Thu, 27 Mar 2003 18:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbTC0Xfc>; Thu, 27 Mar 2003 18:35:32 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59031 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S261312AbTC0Xfc>; Thu, 27 Mar 2003 18:35:32 -0500
Date: Fri, 28 Mar 2003 00:46:25 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] 2.5.66 bio traversal + IDE PIO patches on the way
Message-ID: <Pine.SOL.4.30.0303280012150.24932-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

I have ported Suparna's 2.5.30 bio traversal patches to 2.5.66
dropping bi_voffset+bi_endvoffset code.

Just to remind - bio traversing adds possibility to traverse
bio list partially for i/o submission without affecting completion.
For more detailed info just read second patch (documentation update).

Next patches implement new handlers for IDE PIO.
They use bio traversal and are more correct than current ones.

I have tested them and they are working just fine for me.
If you want to try just apply:

2.5.66-biowalk-core-A0.diff
2.5.66-masked_irq-fix-A0.diff
2.5.66-ide-pio-1-A0.diff
2.5.66-ide-pio-2-A0.diff
and turn on IDE_TASKFILE_IO config option in IDE menu

2.5.66-biowalk-doc-A0.diff
is a documentation update

2.5.66-ide-pio-3-A0.diff
2.5.66-ide-pio-4-A0.diff
are cleanups

As always with block or IDE changes special care is _strongly_
recommended, don't blame me if it eats your fs :-).

--
Bartlomiej Zolnierkiewicz

