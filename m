Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132270AbRAJI3E>; Wed, 10 Jan 2001 03:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132451AbRAJI2y>; Wed, 10 Jan 2001 03:28:54 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:13574
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132270AbRAJI2k>; Wed, 10 Jan 2001 03:28:40 -0500
Date: Wed, 10 Jan 2001 00:28:18 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: KIOBUFS ??
Message-ID: <Pine.LNX.4.10.10101100008160.23071-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LT,

Will this maddness insure that the granularity of the request will be
dependent to the k_dev_t?  Specifically, can one make KIOBUFS do the
sizing of buffer to match the ideal or specified size limits imposed by a
given block device?  Otherwise I will need to design an sub-request layer
to reduce the pain of restarting the entire request because of the huge
DMA-PRD-Chain that has no clue how to report error location and allow a
restart from NxPRD's before the error.

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
