Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTFDAwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTFDAwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:52:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27285 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262494AbTFDAwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:52:46 -0400
Date: Wed, 4 Jun 2003 02:06:13 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@digeo.com>
Cc: Lou Langholtz <ldl@aros.net>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.5.70 add_disk(disk) re-registering disk->queue->elevator.kobj (bug?!)
Message-ID: <20030604010613.GG6754@parcelfarce.linux.theplanet.co.uk>
References: <3EDCEA14.2000407@aros.net> <20030603120717.66012855.akpm@digeo.com> <3EDD3D5F.3010509@aros.net> <20030603180002.2a0b4402.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603180002.2a0b4402.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 06:00:02PM -0700, Andrew Morton wrote:
 
> According to Al, we have a significant number of drivers in the tree in
> which multiple gendisks shared the same queue.  Sometimes because that's a
> logical mapping onto how the hardware behaves.

... on top of that, we have queues with no gendisk ever registered.
SCSI tapes, for one things.
