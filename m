Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129205AbQKTPIL>; Mon, 20 Nov 2000 10:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129256AbQKTPIC>; Mon, 20 Nov 2000 10:08:02 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:5381 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129205AbQKTPH6>;
	Mon, 20 Nov 2000 10:07:58 -0500
Date: Mon, 20 Nov 2000 15:37:44 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: David Ford <david@linux.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [oops] apm and tulip (eeprom.c) related in kernel 2.4.0 test11-pre7
In-Reply-To: <3A175FB5.6C9EE37E@linux.com>
Message-ID: <Pine.LNX.4.21.0011201532430.28348-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2000, David Ford wrote:

> I've been trying [unsuccessfully :S] to get the kernel's pcmcia
> working.  I woke up this morning and found the following oops:

This has nothing to do with the pcmcia support, but with the tulip driver.

The easiest thing to try is to comment away the following code in
tulip/eeprom.c around line 237.

	printk(KERN_INFO "%s:  Index #%d - Media %s (#%d) described "
	   "by a %s (%d) block.\n",
	   dev->name, i, medianame[leaf->media], leaf->media,
	   block_name[leaf->type], leaf->type);

Better yet, download and try the latest tulip driver from sourceforge.net
(search for tulip). I'm sure Jeff Garzik would like to know if it works.

/Tobias


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
