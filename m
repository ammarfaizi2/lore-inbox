Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbREQTYK>; Thu, 17 May 2001 15:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261519AbREQTYA>; Thu, 17 May 2001 15:24:00 -0400
Received: from zeus.kernel.org ([209.10.41.242]:24028 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261513AbREQTXn>;
	Thu, 17 May 2001 15:23:43 -0400
Date: Thu, 17 May 2001 12:22:58 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Updates...ide.2.4.5-p1.05132001...FastTrak...CSB5...AMD761
Message-ID: <Pine.LNX.4.10.10105171211460.938-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What did we do....

First we added two things for the Promise owners.

If you have a FastTrak and you wish to use it in normal mode, we have a
solution now.  Place all the drives in "span" with only one drive per
array.  This makes each array a single device.  This will work; however,
you must set the new Promise Option to enable the HOST regardless.
Do not set this option with Promise's I2O card!

CSB5...erm it is a work in progress but should be fully functional in
24-48 hours.

AMD761 is fully functional upto ATA-66, the ATA-100 feature is not
complete, but will register so...if you board works great, otherwise issue
an hdparm -X68 /dev/hdX to set the HOST into ATA-66 mode.

The dreaded timeout is actively being killed.

The mystery of hot-swap, well see LANANA thread....since there is a freeze
on char-major-10-XXX device points, thus there is a freeeze on this code
coming to Linux. :-(

I hope to have all of this cleaned up and ready for submission for the
pre3/4/5 patch releases.

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

