Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130003AbQL1Mmz>; Thu, 28 Dec 2000 07:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130401AbQL1Mmp>; Thu, 28 Dec 2000 07:42:45 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16401 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130003AbQL1Mm1>; Thu, 28 Dec 2000 07:42:27 -0500
Subject: Re: innd mmap bug in 2.4.0-test12
To: aheitner@andrew.cmu.edu (Ari Heitner)
Date: Thu, 28 Dec 2000 12:14:12 +0000 (GMT)
Cc: cw@f00f.org (Chris Wedgwood), linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.SOL.3.96L.1001228000150.3482A-100000@unix13.andrew.cmu.edu> from "Ari Heitner" at Dec 28, 2000 12:06:47 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Bbwk-0003dO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> does anyone other than me think that the pm code is *way* too agressive about
> spinning down the hard drive? my 256mb laptop (2.2.16) will only spin down the
> disk for about 30 seconds before it decides it's got something else it feels
> like writing out, and spins back up. Spinnup has got to be more wasteful than
> just leaving the drive spinning...

Take that up with your bios. Hard disk power management is done by the drive
and bios settings. hdparm will let you override it. You can also get good
results using noatime to avoid atime writes on reading

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
