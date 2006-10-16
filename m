Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422854AbWJPTcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422854AbWJPTcj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422855AbWJPTcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:32:39 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:8356 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1422854AbWJPTcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:32:39 -0400
Date: Mon, 16 Oct 2006 21:32:37 +0200 (CEST)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@p4.localdomain
To: balagi@justmail.de
cc: Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 2/2] 2.6.19-rc1-mm1 pktcdvd: bio write congestion
In-Reply-To: <E1GZO8u-0006bn-VJ@www14.emo.freenet-rz.de>
Message-ID: <Pine.LNX.4.64.0610162128100.633@p4.localdomain>
References: <E1GZO8u-0006bn-VJ@www14.emo.freenet-rz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, balagi@justmail.de wrote:

> the congestion control will work with both code changes, but i am
> not sure, if using clear_queue_congested() and blk_congestion_wait()
> is the right thing to use here: it works on global level. Any other
> thread/driver/etc. can do a clear_queue_congested() and wake
> up anyone waiting on this global write or read wait queue, resulting to
> unneeded task switches.
> The driver local solution (own waitqueue) would prevent this.....

But it would make the driver more complex. How many extra task switches 
can you get, and how much CPU time does that consume? If it is negligible 
I think it's better to keep the code simple.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
