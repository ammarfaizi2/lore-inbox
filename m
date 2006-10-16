Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWJPEKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWJPEKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 00:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWJPEKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 00:10:50 -0400
Received: from smtpout.mac.com ([17.250.248.175]:34812 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751217AbWJPEKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 00:10:49 -0400
In-Reply-To: <17714.52626.667835.228747@cse.unsw.edu.au>
References: <17710.54489.486265.487078@cse.unsw.edu.au> <1160752047.25218.50.camel@localhost.localdomain> <17714.52626.667835.228747@cse.unsw.edu.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F40F49D8-C870-420C-B6C6-FB14CADBDDA2@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       aeb@cwi.nl, Jens Axboe <jens.axboe@oracle.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Why aren't partitions limited to fit within the device?
Date: Mon, 16 Oct 2006 00:09:29 -0400
To: Neil Brown <neilb@suse.de>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 15, 2006, at 20:08:50, Neil Brown wrote:
> Hmmm.. So Alan things a partially-outside-this-disk partition
> shouldn't show up at all, and Andries thinks it should.
> And both give reasonably believable justifications.
>
> Maybe we need a kernel parameter?  How about this?
>
> [...snip...]
> So provide a kernel-parameter which a 'safe' default.
>
>    partitions=strict
> is the default
>    partitions=relaxed
> means that partitions are clipped rather than rejected.
> This kernel parameters only applies to auto-detected partitions,
> not those set by ioctl.

Perhaps it should also support partitions=none; so that those of us  
who want to use a small userspace program and device-mapper to do the  
partition discovery and access may do so without worrying about how  
the kernel perceives the partitions (if at all).  It also makes it  
fairly trivial to add support for entirely new parition types without  
having to modify the kernel at all.

Cheers,
Kyle Moffett
