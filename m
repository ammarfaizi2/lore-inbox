Return-Path: <linux-kernel-owner+w=401wt.eu-S932689AbXABSKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbXABSKj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbXABSKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:10:39 -0500
Received: from rtr.ca ([64.26.128.89]:3900 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932689AbXABSKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:10:38 -0500
Message-ID: <459AA01C.9090806@rtr.ca>
Date: Tue, 02 Jan 2007 13:10:36 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, Rene Herman <rene.herman@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <4599992D.8000607@rtr.ca> <20070102083414.GQ2483@kernel.dk> <459A73CB.8010901@rtr.ca> <459A8E17.80601@gmail.com> <459A97EC.8090903@rtr.ca> <459A9C30.20204@gmail.com>
In-Reply-To: <459A9C30.20204@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Mark Lord wrote:
>
>>> Support for IDENTIFY PACKET DEVICE would be nice too.
>> It already does that, using HDIO_DRIVE_CMD to retrieve it
>> in the same way as for regular IDENTIFY DEVICE commands.
> 
> Hmmm... My hdparm doesn't seem to do that.

Sure it does.
Try "strace hdparm -I /dev/sr0" and notice the two ioctl() calls.

The problem is that libata/SCSI always fail it for some reason.
Ditto for me right now when I tried it with an SG_IO passthru command.

Contrary to my other posting, I actually *do* have a libata-controlled
DVD/RW drive in my box here.  So I'll try and see what's happening.

Still digging..
