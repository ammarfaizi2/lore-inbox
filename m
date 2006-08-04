Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWHDBCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWHDBCs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 21:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWHDBCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 21:02:48 -0400
Received: from terminus.zytor.com ([192.83.249.54]:53484 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030273AbWHDBCr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 21:02:47 -0400
Message-ID: <44D29C05.4030408@zytor.com>
Date: Thu, 03 Aug 2006 17:59:49 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: Userspace visible of 3 include/asm/ headers
References: <20060803193952.GF25692@stusta.de> <20060803194410.GC16927@redhat.com> <44D26A8B.9040907@zytor.com> <20060803215230.GI25692@stusta.de> <44D28C0A.905@zytor.com> <20060804001221.GM25692@stusta.de>
In-Reply-To: <20060804001221.GM25692@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Aug 03, 2006 at 04:51:38PM -0700, H. Peter Anvin wrote:
>> Adrian Bunk wrote:
>>
>>> On different architectures, we have the following values for 
>>> COMMAND_LINE_SIZE:
>>> - 256
>>> - 512
>>> - 896
>>> - 1024
>>> - 4096
>>>
>>> What should be the common value?
>>> 4096?
>>>
>>> And I have a rough memory of some dependencies of COMMAND_LINE_SIZE and 
>>> boot loaders. What exactly must be taken care of when increasing 
>>> COMMAND_LINE_SIZE?
>>>
>> It's architecture-dependent; it probably should be defined in something 
>> like <asm/cmdline.h>.
> 
> OK, I did misunderstand you.
> I tought you were saying it should be the same value for all 
> architectures.
> 
> With the exception of frv (in param.h), COMMAND_LINE_SIZE is in setup.h 
> on all architectures.
> 
> Do we want to move it to a different header, or simply make param.h a 
> userspace header on all architectures?
> 

I figure it should be broken out into a separate header, rather than 
exporting all of setup.h.

	-hpa
