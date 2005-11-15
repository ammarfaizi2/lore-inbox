Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVKOBCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVKOBCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 20:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVKOBCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 20:02:53 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:27940 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932178AbVKOBCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 20:02:53 -0500
Date: Mon, 14 Nov 2005 19:02:46 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-reply-to: <58UQf-6Da-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <437933B6.1000503@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <58MJb-2Sn-37@gated-at.bofh.it> <58NvO-46M-23@gated-at.bofh.it>
 <58Rpx-1m6-11@gated-at.bofh.it> <58UGF-6qR-27@gated-at.bofh.it>
 <58UQf-6Da-3@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giridhar Pemmasani wrote:
> Shouldn't I have to prevent scheduler from changing the tasks when executing
> Windows code? Otherwise, kernel gets wrong current thread information,
> which is based on stack pointer. This is the stumbling block for implementing
> private stacks.

As long as preemption is disabled when the driver code is executing I 
don't see how this would happen.. I don't know much of how ndiswrapper 
does things but if the driver calls back into your code then you'd just 
have to change the stack back before doing anything that could schedule.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

