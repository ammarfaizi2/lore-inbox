Return-Path: <linux-kernel-owner+w=401wt.eu-S1030376AbWLTVyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWLTVyf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWLTVye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:54:34 -0500
Received: from 85.189.5.98 ([85.189.5.98]:38502 "EHLO zombie.undead"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030373AbWLTVyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:54:33 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 16:54:33 EST
Message-ID: <45899FBD.9070803@hayter.me.uk>
Date: Wed, 20 Dec 2006 20:40:29 +0000
From: Steven Hayter <steven@hayter.me.uk>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Dan Aloni <da-x@monatomic.org>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [PATCH] scsi_execute_async() should add to the tail of the queue
References: <20061219000234.GA5330@localdomain>
In-Reply-To: <20061219000234.GA5330@localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 10.3.0.179
X-SA-Exim-Mail-From: steven@hayter.me.uk
X-SA-Exim-Scanned: No (on zombie.undead); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
> Hello,
> 
> scsi_execute_async() has replaced scsi_do_req() a few versions ago, 
> but it also incurred a change of behavior. I noticed that over-queuing 
> a SCSI device using that function causes I/Os to be starved from 
> low-level queuing for no justified reason.
>  
> I think it makes much more sense to perserve the original behaviour 
> of scsi_do_req() and add the request to the tail of the queue.

As far as I'm aware the way in which scsi_do_req() was to insert at the 
head of the queue, leading to projects like SCST to come up with 
scsi_do_req_fifo() as queuing multiple commands using scsi_do_req() with 
constant head insertion might lead to out of order execution.

Just thought I'd throw some light on the history and what others have 
done in the past.

Steve
