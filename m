Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbTITS2x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 14:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTITS2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 14:28:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15050 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261935AbTITS2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 14:28:51 -0400
Message-ID: <3F6C9C55.6050608@pobox.com>
Date: Sat, 20 Sep 2003 14:28:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se> <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk> <20030913184934.GB10047@gtf.org> <20030913190131.GD10047@gtf.org> <20030915073445.GC27105@suse.de> <20030916194955.GC5987@gtf.org> <20030916195515.GC906@suse.de>
In-Reply-To: <20030916195515.GC906@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Sep 16 2003, Jeff Garzik wrote:

>>And we should deprecate them with a solution that aligns what with Linus
>>described in Dec 2001 on lkml:  a chrdev where userland write(2)s cdbs
>>and taskfiles, and read(2)s the results.  This is where my thinking
>>picked up:  if we are creating a chrdev to send "packets" and receive
>>responses to those packets............  <insert conclusion here>
> 
> 
> == bsg, block sg. Did you read what I wrote? :). I started implementing
> this and have something that barely works. You just bind a block device
> to a /dev/sg* char device and use read/write on that. Aka sg.

sg needs some modifications -- for example it errors out instead of 
sleeps on queue full -- but sounds good to me.


> I don't want ioctls command submission interfaces more than you do.

Groovy.

	Jeff



