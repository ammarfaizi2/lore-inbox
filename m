Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVBAPVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVBAPVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 10:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVBAPVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 10:21:19 -0500
Received: from mail.tmr.com ([216.238.38.203]:2567 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262037AbVBAPVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 10:21:14 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [2.6 patch] mark the mcd cdrom driver as BROKEN
Date: Tue, 01 Feb 2005 10:24:56 -0500
Organization: TMR Associates, Inc
Message-ID: <41FF9F48.60008@tmr.com>
References: <20050129182255.37b8fe2c.khali@linux-fr.org><20050129182255.37b8fe2c.khali@linux-fr.org> <20050129191430.GF28047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1107270631 30955 192.168.12.100 (1 Feb 2005 15:10:31 GMT)
X-Complaints-To: abuse@tmr.com
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
To: Adrian Bunk <bunk@stusta.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20050129191430.GF28047@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, Jan 29, 2005 at 06:22:55PM +0100, Jean Delvare wrote:
> 
>>Hi Adrian,
>>
>>
>>>The mcd driver drives only very old hardware (some single and double 
>>>speed CD drives that were connected either via the soundcard or a 
>>>special ISA card), and the mcdx driver offers more functionality for
>>>the  same hardware.
>>>
>>>My plan is to mark MCD as broken in 2.6.11 and if noone complains 
>>>completely remove this driver some time later.
>>>(...)
>>>-	depends on CD_NO_IDESCSI
>>>+	depends on CD_NO_IDESCSI && BROKEN
>>
>>Shouldn't we introduce a DEPRECATED option for use in cases like this
>>one?
> 
> 
> We could.
> 
> We could also list MCD in Documentation/feature-removal-schedule.txt 
> first.
> 
> But in this case I doubt it makes any difference.
> 
> This driver is for hardware where I doubt many users exist today, and it 
> should have been removed nearly ten years ago when the better mcdx 
> driver for the same now-obsolete hardware entered the kernel.

I actually have one (or two) of these, but I agree that in this case it 
makes no difference. As a general thing I think DEPRECIATED would be 
useful for the case where there is a newer functional driver. The 
systems I have are unlikely to ever run a current kernel, so I am not 
affected, and I suspect most others who have this old stuff are running 
2.0 or 2.2 kernels, also.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
