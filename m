Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131627AbQLMPPf>; Wed, 13 Dec 2000 10:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131625AbQLMPPP>; Wed, 13 Dec 2000 10:15:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34315 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131624AbQLMPPI>; Wed, 13 Dec 2000 10:15:08 -0500
Subject: Re: [PATCH] 2.2.18 ext2 large file bug?
To: adilger@turbolinux.com (Andreas Dilger)
Date: Wed, 13 Dec 2000 14:46:04 +0000 (GMT)
Cc: ext2-devel@lists.sourceforge.net (Ext2 development mailing list),
        linux-fsdevel@vger.kernel.org (Linux FS development list),
        linux-kernel@vger.kernel.org (Linux kernel development list)
In-Reply-To: <200012130814.eBD8ELc10852@webber.adilger.net> from "Andreas Dilger" at Dec 13, 2000 01:14:21 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146DAV-0002qV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> also needs to be fixed in 2.2.  Basically, we are checking for an ext2
> large file, which would be a file > 2GB on systems that don't support
> such.  However, we are checking for a file > 8GB which is clearly wrong.
> The ext3 version of the patch is also attached.

Umm..

	x>>33

is checking 8Gig

	x>>31 

is checking 2Gig

So your patch seems backwards

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
