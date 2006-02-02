Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWBBUco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWBBUco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWBBUco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:32:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48137 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932212AbWBBUcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:32:43 -0500
Date: Thu, 2 Feb 2006 21:35:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing - related question
Message-ID: <20060202203503.GH4215@suse.de>
References: <43DEA195.1080609@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DEA195.1080609@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30 2006, Bill Davidsen wrote:
> Please take this as a question to elicit information, not an invitation 
> for argument.
> 
> In Linux currently:
>  SCSI - liiks like SCSI
>  USB - looks like SCSI
>  Firewaire - looks like SCSI
>  SATA - looks like SCSI

SATA will _not_ look like SCSI in the future.

>  Compact flash and similar - looks like SCSI

? CF adapters are usually IDE, so looks like ATA.

>  ATAPI - looks different unless ide-scsi used

But it's all besides the point, it doesn't matter what the device
special file looks like (if it's SCSI or not). What matters is that you
talk to the device the same way - and that way is currently SG_IO.

That a device hangs off the SCSI stack because that is the way the
author wrote eg usb-storage is irrelevant. What matters is that you open
the device in question and use SG_IO to talk to it.

Talking about the SCSI stack and ide-scsi completely misses the point.

-- 
Jens Axboe

