Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVE3Tkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVE3Tkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVE3Tkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:40:31 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:26187 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261722AbVE3TiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:38:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=NJh0mFkAEDZ9fLoVhZhYW21NNj+Jotw2mBXbaHncw/Rw3oYwwhla3c4XrOreZxmdK7WKMvd1k8Pq2UqOXKIF977X3bvv5FnLPkkPkPmokZFFkz0TrP9IlLq5TrsZWu6AMZQP7CKRMsT2zKOxjdc6dto8RdLg8LkC+vfur0eS6f8=
Message-ID: <429B6B9E.1080709@gmail.com>
Date: Tue, 31 May 2005 04:38:06 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: James.Bottomley@steeleye.com, bzolnier@gmail.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc5-mm1 00/06] blk: barrier flushing reimplementation
References: <20050529042034.5FF4CF1C@htj.dyndns.org> <20050529191437.GA30586@suse.de> <20050530113133.GP7054@suse.de>
In-Reply-To: <20050530113133.GP7054@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sun, May 29 2005, Jens Axboe wrote:
> 
>>On Sun, May 29 2005, Tejun Heo wrote:
>>
>>> Hello, guys.
>>>
>>> This patchset is reimplementation of QUEUE_ORDERED_FLUSH feature.  It
>>>doens't update API docs yet.  If it's determined that this patchset
>>>can go in, I'll regenerate this patchset with doc updates (sans the
>>>last debug message patch of course).
>>
>>Awesome work, that's really the last step in getting the barrier code
>>fully unified and working with tags. I'll review your patchset tomorrow.
> 
> 
> Patches look nice, this is a good step forward. If you feel like doing a
> little more work in this area, I would very much like to add
> QUEUE_ORDERED_FUA as a third method for implementing barriers. Basically
> it would use the FUA commands to put data safely on disk, instead of
> using the post flushes.
> 
> For NCQ, we have a FUA bit in the FPDMA commands. For non-ncq, we have
> the various WRITE_DMA_EXT_FUA (and similar). It would be identical to
> ORDERED_FLUSH in that we let the queue drain, issue a pre-flush, and
> then a write with FUA set. It would eliminate the need to issue an extra
> flush at the end, cutting down the required commands for writing a
> barrier from 3 to 2.
> 

  Hi, Jens.

  I'm on it.

  Thanks.

-- 
tejun
