Return-Path: <linux-kernel-owner+w=401wt.eu-S1423106AbWLUXAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423106AbWLUXAF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 18:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423107AbWLUXAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 18:00:05 -0500
Received: from www.nabble.com ([72.21.53.35]:34712 "EHLO talk.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423106AbWLUXAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 18:00:04 -0500
Message-ID: <8016586.post@talk.nabble.com>
Date: Thu, 21 Dec 2006 15:00:02 -0800 (PST)
From: business1 <coreyu@bsgteamsite.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] rqbased-dm: add block layer hook
In-Reply-To: <20061220.165246.85417944.k-ueda@ct.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: coreyu@bsgteamsite.com
References: <20061219.171150.75425661.k-ueda@ct.jp.nec.com> <20061220134924.GG10535@kernel.dk> <20061220.165246.85417944.k-ueda@ct.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Kiyoshi Ueda wrote:
> 
> Hi Jens,
> 
> Sorry for the less explanation.
> 
> On Wed, 20 Dec 2006 14:49:24 +0100, Jens Axboe <jens.axboe@oracle.com>
> wrote:
>> On Tue, Dec 19 2006, Kiyoshi Ueda wrote:
>> > This patch adds new "end_io_first" hook in __end_that_request_first()
>> > for request-based device-mapper.
>> 
>> What's this for, lack of stacking?
> 
> I don't understand the meaning of "lack of stacking" well but
> I guess that it means "Is the existing hook in end_that_request_last()
> not enough?"  If so, the answer is no.
> (If the geuss is wrong, please let me know.)
> 
> The new hook is needed for error handling in dm.
> For example, when an error occurred on a request, dm-multipath
> wants to try another path before returning EIO to application.
> Without the new hook, at the point of end_that_request_last(),
> the bios are already finished with error and can't be retried.
> 
> Thanks,
> Kiyoshi Ueda
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
>   Look at me im boolin  
> http://www.thebusinesssuccessgroup.com/Real-Estate-Investment-training.html
-- 
View this message in context: http://www.nabble.com/-RFC-PATCH-2-8--rqbased-dm%3A-add-block-layer-hook-tf2848786.html#a8016586
Sent from the linux-kernel mailing list archive at Nabble.com.

