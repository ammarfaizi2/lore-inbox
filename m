Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVC3A6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVC3A6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 19:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVC3A6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 19:58:05 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:58773 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261427AbVC3A5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 19:57:54 -0500
Message-ID: <4249F98D.9040706@yahoo.com.au>
Date: Wed, 30 Mar 2005 10:57:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com> <20050329080646.GE16636@suse.de> <42491DBE.6020303@yahoo.com.au> <20050329092819.GK16636@suse.de> <424928A1.8060400@yahoo.com.au>
In-Reply-To: <424928A1.8060400@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Jens Axboe wrote:
> 
>> Looks good, I've been toying with something very similar for a long time
>> myself.
>>
> 
> Here is another thing I just noticed that should further reduce the
> locking by at least 1, sometimes 2 lock/unlock pairs per request.
> At the cost of uglifying the code somewhat. Although it is pretty
> nicely contained, so Jens you might consider it acceptable as is,
> or we could investigate how to make it nicer if Kenneth reports some
> improvement.
> 
> Note, this isn't runtime tested - it could easily have a bug.
> 

OK - I have booted this on a 4-way SMP with SCSI disks, and done
some IO tests, and no hangs.

So Kenneth if you could look into this one as well, to see if
it is worthwhile, that would be great.

