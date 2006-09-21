Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWIUTOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWIUTOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 15:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWIUTOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 15:14:05 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:25740 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751478AbWIUTOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 15:14:03 -0400
Message-ID: <4512E472.7070005@cs.wisc.edu>
Date: Thu, 21 Sep 2006 14:13:54 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: support larger block pc requests take 2
References: <11583761161108-git-send-email-michaelc@cs.wisc.edu> <20060921184024.GB16556@kernel.dk> <20060921185939.GH16556@kernel.dk>
In-Reply-To: <20060921185939.GH16556@kernel.dk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Sep 21 2006, Jens Axboe wrote:
>> On Fri, Sep 15 2006, michaelc@cs.wisc.edu wrote:
>>> From: Mike Christie <michaelc@cs.wisc.edu>
>>>
>>> This patch modifies blk_rq_map/unmap_user() so that it supports
>>> requests larger than bio by chaning them together.
>>>
>>> Changes since v1.
>>> 1. Removed blk_get_bounced_bio() function. blk_rq_unmap_user
>>> checks the bounced flag and if set access bi_private.
>>>
>>> 2. Removed biohead_orig field from request.
>>> Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
>> Patches 1+2 applied, thanks Mike!
> 
> Tested, and no good. You can't split it into two patches, if it doesn't
> compile with 1/2 applied. If scsi_ioctl.c needs to be changed, do it
> with the change and not in the next patch. Otherwise bisecting breaks.
> 

Ok.

> Care to resubmit? Just combine the two, but split the bsg patch as that

Will do. Just a sec. Downloading from kernel.org is a little slow. I
will send in another thread in case you have some fancy script in a
couple minutes.

> needs to go into a separate branch for now. The bsg patch will just be
> merged into the bsg patch set, as that needs to be based on 'block'
> anyway.
> 

