Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbRBLJej>; Mon, 12 Feb 2001 04:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRBLJe3>; Mon, 12 Feb 2001 04:34:29 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:12479 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129053AbRBLJeY>;
	Mon, 12 Feb 2001 04:34:24 -0500
Message-Id: <m14SFN4-000OaIC@amadeus.home.nl>
Date: Mon, 12 Feb 2001 10:34:10 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: ppetru@ppetru.net (Petru Paler)
Subject: Re: RAID1 read balancing
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <20010211161242.A949@ppetru.net>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010211161242.A949@ppetru.net> you wrote:

> For a RAID1 array built of two disks on two separate SCSI controllers,
> are the reads balanced between the two controllers (for higher speed) ?

With the current RAID1 setup, you will NOT get a speed increase for
single-threaded, sequential reading programs (read: benchmarks like hdparm
and tiobench)[1]. You will get improvents in all other cases.

Greetings,
   Arjan van de Ven


[1] This can be fix by a 10 line patch, however this changes the on-disk
layout.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
