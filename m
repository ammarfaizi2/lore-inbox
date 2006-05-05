Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWEEV7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWEEV7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 17:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWEEV7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 17:59:36 -0400
Received: from terminus.zytor.com ([192.83.249.54]:63684 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751787AbWEEV7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 17:59:35 -0400
Message-ID: <445BCA33.30903@zytor.com>
Date: Fri, 05 May 2006 14:57:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: John Coffman <johninsd@san.rr.com>
CC: Alon Bar-Lev <alon.barlev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       tony.luck@intel.com
Subject: Re: [PATCH][TAKE 4] THE LINUX/I386 BOOT PROTOCOL - Breaking   the
 256 limit
References: <445B5524.2090001@gmail.com> <445B5C92.5070401@zytor.com> <445B610A.7020009@gmail.com> <445B62AC.90600@zytor.com> <6.2.3.4.0.20060505110517.036df928@pop-server.san.rr.com> <445B96D2.9070301@zytor.com> <6.2.3.4.0.20060505144445.03642988@pop-server.san.rr.com>
In-Reply-To: <6.2.3.4.0.20060505144445.03642988@pop-server.san.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Coffman wrote:
>>
>> The problem is that some people have reported that the kernel crashes 
>> if booted with LILO and the size limit is more than 255.  They haven't 
>> so far commented on how they observed that, and that's a major problem.
> 
> Just re-compiling LILO with the  COMMAND_LINE_SIZE  parameter changed 
> from 256 to 512 will not work.  A .bss area must be moved to avoid 
> clobbering the kernel header.
> 

Okay, let me ask this:

If the *kernel* limit is modified, but the LILO limit is not, what will happen?  This is 
the real crux of the matter.

	-hpa
