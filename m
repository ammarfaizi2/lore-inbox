Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWJLT6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWJLT6K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWJLT6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:58:10 -0400
Received: from zcars04f.nortel.com ([47.129.242.57]:51700 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP
	id S1750768AbWJLT6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:58:09 -0400
Message-ID: <452E9E47.8070306@nortel.com>
Date: Thu, 12 Oct 2006 13:57:59 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net>
In-Reply-To: <452E62F8.5010402@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2006 19:58:02.0913 (UTC) FILETIME=[B9C85110:01C6EE38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:

> Linux ported onto the L4-Iguana microkernel is reported to be faster
> than the monolith[1]; it's not like microkernels are faster, but the
> L4-Iguana apparently just has super awesome context switching code:
> 
>    Wombat's context-switching overheads as measured by lmbench on an
>    XScale processor are up to thirty times less than those of native
>    Linux, thanks to Wombat profiting from the implementation of fast
>    context switches in L4-embedded.

The Xscale is a fairly special beast, and it's context-switch times are 
pretty slow by default.

Here are some context-switch times from lmbench on a modified 2.6.10 
kernel. Times are in microseconds:

cpu		clock speed	context switch	
pentium-M	1.8GHz		0.890
dual-Xeon	2GHz		7.430
Xscale		700MHz		108.2
dual 970FX	1.8GHz		5.850
ppc 7447	1GHz		1.720

Reducing the Xscale time by a factor of 30 would basically bring it into 
line with the other uniprocessor machines.

Chris
