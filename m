Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264457AbTCXWRA>; Mon, 24 Mar 2003 17:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264475AbTCXWRA>; Mon, 24 Mar 2003 17:17:00 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:23566 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264457AbTCXWQ6>; Mon, 24 Mar 2003 17:16:58 -0500
Date: Mon, 24 Mar 2003 23:28:01 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
In-Reply-To: <UTC200303242206.h2OM65A29479.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0303242312250.12110-100000@serv>
References: <UTC200303242206.h2OM65A29479.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 Mar 2003 Andries.Brouwer@cwi.nl wrote:

> > I still don't know what we need ranges or even subranges for.
> > What problem are you trying to solve?
> 
> I mentioned the structure of Al's block device code to you.
> Haven't you read blk_register_region()?

I did, have you seen add_disk()? Did you notice that more drivers use 
add_disk() than blk_register_region() and that most of the 
blk_register_region() users are legacy drivers?
Which character device has partitions? Even for block devices it will be 
easier to just define MAX_PART_NR and simply use a constant shift to get 
from a partition to the disk.
Please try to keep the problem simple, all examples I've seen so far only 
can be dealt with quite easily. So which problem requires a complex 
(sub)ranges solution?

bye, Roman

