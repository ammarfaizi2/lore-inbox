Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVKOCXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVKOCXe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVKOCXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:23:34 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:56046 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932260AbVKOCXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:23:33 -0500
Date: Mon, 14 Nov 2005 20:22:30 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-reply-to: <1132020468.27215.25.camel@mindpipe>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43794666.7020600@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <58MJb-2Sn-37@gated-at.bofh.it> <58NvO-46M-23@gated-at.bofh.it>
 <58Rpx-1m6-11@gated-at.bofh.it> <58UGF-6qR-27@gated-at.bofh.it>
 <58UQf-6Da-3@gated-at.bofh.it> <437933B6.1000503@shaw.ca>
 <1132020468.27215.25.camel@mindpipe>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
>>As long as preemption is disabled when the driver code is executing
> 
> Um, but it's really really bad for drivers to do that.

Normally yes.. but that may be a sacrifice that may have to be made 
considering what ndiswrapper is doing - inserting blobs of code into the 
kernel that were never designed to run there. I would think that would 
be something you would want to do with such a driver regardless of stack 
switching - do we have any way of knowing whether the Windows driver is 
doing some timing-dependent thing that will cause bad things to happen 
if we take away the CPU from it in the middle?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

