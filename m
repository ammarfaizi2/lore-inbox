Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268702AbUHaPJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbUHaPJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268703AbUHaPJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:09:28 -0400
Received: from mail.tmr.com ([216.238.38.203]:63749 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268702AbUHaPJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:09:17 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH 2.6.9-rc1-mm1] Disable colour conversion in the CPiA Video
 Camera driver
Date: Tue, 31 Aug 2004 11:10:07 -0400
Organization: TMR Associates, Inc
Message-ID: <ch23uh$8hi$2@gatekeeper.tmr.com>
References: <20040830013201.7d153288.akpm@osdl.org><20040830013201.7d153288.akpm@osdl.org> <20040830133205.GC1727@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1093964562 8754 192.168.12.100 (31 Aug 2004 15:02:42 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <20040830133205.GC1727@bytesex>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
>>Given that colour conversion is not allowed in kernel space, this patch
>>disables it in the CPiA driver. The routines implementing the conversions
>>can be removed at all by the maintainers of the driver; however, this
>>patch is a good starting point and makes someone happy.
> 
> 
> Yes, colorspace conversion shouldn't be done by the kernel but by the
> applications.  I don't like the idea to just disable them through:
> 
> First: there should be a reasonable warning time for the current users.
> Some printk message telling them they are using a depricated feature.
> Maybe even a insmod option to enable/disable it, with the default being
> software conversion disabled.
> 
> Second: IMHO it would be a very good idea to port the driver to the v4l2
> API before ripping the in-kernel colorspace conversion support.  v4l2
> provides a sane API to get a list of supported color formats, whereas
> with v4l1 it is dirty trial-and-error + guesswork for the applications.

The side effect, a list of supported color formats, is a good one. 
Perhaps someone will suggest some better way to accomplish this than is 
currently the case.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
