Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWGYMw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWGYMw1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 08:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWGYMw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 08:52:26 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:23964 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1751392AbWGYMwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 08:52:24 -0400
Subject: Re: loopback blockdevice driver partition support
From: Kasper Sandberg <lkml@metanurb.dk>
To: Neil Brown <neilb@suse.de>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <17605.22477.933202.350306@cse.unsw.edu.au>
References: <1153783192.11477.7.camel@localhost>
	 <17605.22477.933202.350306@cse.unsw.edu.au>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 14:52:21 +0200
Message-Id: <1153831941.11477.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 09:29 +1000, Neil Brown wrote:
> On Tuesday July 25, lkml@metanurb.dk wrote:
> > hello.. i was wondering if someone may have done some work to make the
> > loopback driver support partitions..
> > 
> > i found that a guy had written a nice script that used sfdisk and
> > dmsetup to use device mapper on a loopback image of an entire harddrive
> > (using DOS partition table ofcourse) to create device mapper
> > "partitions".
> > 
> > though this doesent quite meet my requirements, as i need to read an
> > image of an amiga disk..
> > 
> > therefore it would seem like a good idea to make the loopback driver
> > work with linux's partition table support, since it already supports
> > this.
> > 
> > if anyone has done some work in this, please mail me, and possibly i can
> > continue it if wanted. just want to know if anyone already has done
> > something like it before i try at it myself..
> > 
> 
> You could try wrapping an md/linear around it
>  
> mkdir -p /dev/md
> mdadm -Bf -c4 -l linear -n1 -ap /dev/md/d0 /dev/loop0
> 
> then look at partitions in /dev/md/d0pN
Yeah, i ended up doing this, i found that md supports partitions, and
linear was a perfect match for what i needed.

> 
> NeilBrown
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

