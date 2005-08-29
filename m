Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVH2Xui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVH2Xui (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVH2Xui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:50:38 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:18122 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932079AbVH2Xuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:50:37 -0400
Date: Mon, 29 Aug 2005 17:50:29 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: kernel panic
In-reply-to: <4GLD8-5Wa-27@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43139F45.3020406@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4GLD8-5Wa-27@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

manomugdha biswas wrote:
> Hi,
> I am using the following makefile and the .c file to
> generate a kernel module. I can load this module
> without error and warning. But when I call ioctl()
> from user application to run this module it gets
> kernel panic!

I think there's something wrong with the way you're using the wait queue 
(they're not normally instantiated as local variables on the stack, for 
one thing). It looks like you're just using it to create a delay, in 
that case use schedule_timeout, msleep, etc.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

