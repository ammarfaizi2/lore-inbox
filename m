Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbSLRGKO>; Wed, 18 Dec 2002 01:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbSLRGKO>; Wed, 18 Dec 2002 01:10:14 -0500
Received: from holomorphy.com ([66.224.33.161]:16571 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267175AbSLRGKO>;
	Wed, 18 Dec 2002 01:10:14 -0500
Date: Tue, 17 Dec 2002 22:17:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Greg KH <greg@kroah.com>
Cc: chris@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: converting cap_set_pg() to for_each_task_pid()
Message-ID: <20021218061744.GG1922@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Greg KH <greg@kroah.com>, chris@wirex.com,
	linux-kernel@vger.kernel.org
References: <20021218055742.GE12812@holomorphy.com> <20021218060551.GM28629@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218060551.GM28629@kroah.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 09:57:42PM -0800, William Lee Irwin III wrote:
>> I have a pending patch that converts cap_set_pg() to the
>> for_each_task_pid() API. Could you review this, and if it
>> pass, include it in your tree?

On Tue, Dec 17, 2002 at 10:05:51PM -0800, Greg KH wrote:
> This is functionally the same, right?
> And if so, why do the change, is this now faster somehow?

It is functionally equivalent. The motivation is not so much
performance as API conversion. I am personally taking it upon
myself to deprecate for_each_process() and do_each_thread() and
update the mergeably correctible callers. The deprecation motives
are both efficiency and correctness related.

It should improve performance in whatever sense performance is
interesting from the point of view of this function; however,
it is not motivated by that fact (and performance is not of interest
with respect to most security functions). It is API conversion.


Thanks,
Bill
