Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTIUJXu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 05:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbTIUJXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 05:23:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20370 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261947AbTIUJXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 05:23:49 -0400
Date: Fri, 1 Jan 1904 00:08:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Message-ID: <19031231230857.GA1050@suse.de>
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se> <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk> <20030913184934.GB10047@gtf.org> <20030913190131.GD10047@gtf.org> <20030915073445.GC27105@suse.de> <20030916194955.GC5987@gtf.org> <20030916195515.GC906@suse.de> <3F6C9C55.6050608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6C9C55.6050608@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 20 2003, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Tue, Sep 16 2003, Jeff Garzik wrote:
> 
> >>And we should deprecate them with a solution that aligns what with Linus
> >>described in Dec 2001 on lkml:  a chrdev where userland write(2)s cdbs
> >>and taskfiles, and read(2)s the results.  This is where my thinking
> >>picked up:  if we are creating a chrdev to send "packets" and receive
> >>responses to those packets............  <insert conclusion here>
> >
> >
> >== bsg, block sg. Did you read what I wrote? :). I started implementing
> >this and have something that barely works. You just bind a block device
> >to a /dev/sg* char device and use read/write on that. Aka sg.
> 
> sg needs some modifications -- for example it errors out instead of 
> sleeps on queue full -- but sounds good to me.

Definitely. bsg will be a new implementation from scratch, also dumping
a lot of really (imo) useless "features" that clutter up the code. And
yes, of course it should honor the typical write(2) model :)

-- 
Jens Axboe

