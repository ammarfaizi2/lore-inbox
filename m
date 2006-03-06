Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751976AbWCFSas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbWCFSas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbWCFSas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:30:48 -0500
Received: from codepoet.org ([166.70.99.138]:13269 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1751549AbWCFSar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:30:47 -0500
Date: Mon, 6 Mar 2006 11:30:46 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] bsg, block layer sg
Message-ID: <20060306183046.GA15179@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
References: <20060302111945.GG4329@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302111945.GG4329@suse.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Mar 02, 2006 at 12:19:46PM +0100, Jens Axboe wrote:
> Hi,
> 
> After all that SG_IO and cdrecord talk, I decided to brush off the bsg
> driver I wrote some time ago. Basically this is a full (aims to be at
> least, probably still some minor bits missing) SG v3 interface. It
> supports both SG_IO (which we just pass through for now), as well as
> read/write and readv/writev of sg_io_hdr structures.

After this is merged I suppose I could then, i.e.  run an SG_IO
ioctl doing i.e.  INQUIRY_CMD with some random block device, such
as an /dev/nbd0, or /dev/loop0, or some such.  Which in general
does not seem to make any sense at all unless the block device
has some physical device level support for SCSI/ATAPI/MMC.  So
while it addresses the needs of cdrecord and friends for CD
burning, does it make sense to implement this as a general
capability for all block devices?  I'm not objecting or arguing,
I'm simply puzzled why a generic SG_IO layer for _all_ block
devices (whether SCSI/ATAPI/MMC capable or not) is useful?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
