Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVAMG6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVAMG6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 01:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVAMG6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 01:58:46 -0500
Received: from h-66-134-203-88.snvacaid.covad.net ([66.134.203.88]:54073 "EHLO
	mail.zanfx.com") by vger.kernel.org with ESMTP id S261177AbVAMG6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 01:58:44 -0500
Message-ID: <41E61C68.10801@zanfx.com>
Date: Wed, 12 Jan 2005 22:59:52 -0800
From: "Paul A. Sumner" <paul@zanfx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040622
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: High write latency, iowait, slow writes 2.6.9
References: <41E4BB99.90908@zanfx.com> <cs44ai$oet$1@news.cistron.nl>
In-Reply-To: <cs44ai$oet$1@news.cistron.nl>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks... I've tried the as, deadline and cfq schedulers. Deadline is
giving me the best results. I've also tried tweaking the stuff in
/sys/block/sda/queue/iosched/.

For lack of a better way of describing it, it seems like something is
thrashing.

Miquel van Smoorenburg wrote:
> In article <41E4BB99.90908@zanfx.com>,
> Paul A. Sumner <paul@zanfx.com> wrote:
> 
>>I have a new server that during big io tasks, e.g., bonnie++ and
>>tiobench testing, becomes very unresponsive. Both bonnie++ and tiobench
>>show good read performance, but the write performance lags, max
>>latencies are into the *minutes* and it experiences extended high
>>iowait. I'm guessing the iowait may not be a real problem. The machine
>>is as follows:
> 
> 
> Try another IO scheduler (boot with elevator=deadline or elevator=cfq
>  on the kernel command line)
> 
> Mike.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Paul A. Sumner
Principal Software Engineer

Moore Iacofano Goltsman, Inc. (MIG)
800 Hearst Avenue
Berkeley, CA  94710
Office: 510-845-7549 ext. 191
FAX:   510-845-8750
Mobile: 510-812-1520


