Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263501AbTIIJ5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 05:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTIIJ5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 05:57:13 -0400
Received: from [195.228.254.150] ([195.228.254.150]:50139 "EHLO localhost")
	by vger.kernel.org with ESMTP id S263501AbTIIJ5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 05:57:12 -0400
Date: Tue, 9 Sep 2003 11:57:11 +0200
From: Peter Werner <The.Local.Hacker@vasas.no-ip.org>
To: linux-kernel@vger.kernel.org
Subject: Re: usb-storage: how to ruin your hardware(?)
Message-ID: <20030909095711.GB19624@vasas.no-ip.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <bin9ne$u7n$1@tangens.hometree.net> <200308291611.h7TGBv6j010283@wildsau.idv.uni.linz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308291611.h7TGBv6j010283@wildsau.idv.uni.linz.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> overwriting the drive with zeroes doesn't harm it. but in the meantime,
> I found out how I managed to confuse the drive. as I wrote in a previous
> email, I tried to make the drive look like it has a "real partition table",
> I just copied the one from /dev/hda. Then, I did an mke2fs. Of course,
> my harddisk is larger then the flashdisk, but I expected an error-message
> and not the behaviour I see. So, one can say, trying to access the drive
> beyond its physical limits "ruins" it. But it's always possible to repair
> such a drive with the vendor supplied formating utility, which is windows
> only, which is why I didn't notice it until three days ago. (First time I
> use such a thing).

AFAIK NAND flash devices have bad sectors and a bad-block table usually at
the end of the device.  That could be the reason why you can ruin your
device writing beyond the reported capacity.  The formatting tool can reset
this area.  You can try to save the area beyond the reported capacity,
overwrite it &c. as you did with the beginning of the drive.  It's not
really kernel related.  The point, as you pointed out, is that the kernel
should handle this failure better.

  Peter Werner
