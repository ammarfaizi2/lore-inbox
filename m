Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317888AbSHPBpE>; Thu, 15 Aug 2002 21:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317898AbSHPBpE>; Thu, 15 Aug 2002 21:45:04 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:15264 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317888AbSHPBpC>;
	Thu, 15 Aug 2002 21:45:02 -0400
Date: Thu, 15 Aug 2002 21:48:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Dike <jdike@karaya.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Eliminate root_dev_names - part 1 of 2
In-Reply-To: <200208151938.OAA02692@ccure.karaya.com>
Message-ID: <Pine.GSO.4.21.0208152146100.11149-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Aug 2002, Jeff Dike wrote:

> This patch changes all instances of get_gendisk to get_gendisk_by_kdev_t.
> 
> The following patch, which actually removes the root_dev_names array,
> introduces get_gendisk_by_name, so this keeps the naming somewhat consistent.

Leave it alone for now.  I'm one driver away from per-disk gendisks
(i2o is the last remaining) and as soon as I'm done with it there will
be a lot of changes in that area.  I.e. tonight.

BTW, disk_name() and get_gendisk() will disappear from the export
list, being replaced by partition_name() (taken out of md.c, exported
and sans the "cache" - it doesn't give any benefits anymore).

