Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUIORB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUIORB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUIORB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:01:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61621 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266820AbUIORB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:01:28 -0400
Message-ID: <41487558.7010404@pobox.com>
Date: Wed, 15 Sep 2004 13:01:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lsml@rtr.ca>
CC: dougg@torque.net, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
References: <414711AC.5030200@rtr.ca> <41471A84.4090200@pobox.com> <4147C38C.3000104@torque.net> <414839F0.20008@rtr.ca>
In-Reply-To: <414839F0.20008@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Currently on Linux, that interface is called "SCSI".
> I think it might not be unreasonable to gradually evolve
> the SCSI host interface to include, say, a non-translating
> queuecommand() method, and associated pals.
[...]
> We practically have that already today.
> The SCSI mid-layer is a nice generic block device glue system.
> We just need perhaps to make it less SCSI-specific.


You seem to have independent reached the same conclusion I did :)

To be specific, SCSI provides LLD infrastructure that block does not:
1) infrastructure for queueing, retrying, and timing out requests
2) an error handling thread.
3) a standard method of addressing attached devices
4) a standard method of submitting raw commands from userspace

It is my goal to shift this infrastructure from SCSI to block over time. 
  There is a fair amount of queueing infrastructure now in 2.6 (part of 
#1), and Jens already has test code for #4.

I had hoped to start working on this in 2.7, but with the new dev model 
2.7 is postponed indefinitely....  so I guess I'll start working on it 
sooner rather than later :)

	Jeff


