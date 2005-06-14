Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVFNHnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVFNHnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVFNHna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:43:30 -0400
Received: from mf01.sitadelle.com ([212.94.174.80]:20375 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S261310AbVFNHnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:43:15 -0400
Message-ID: <42AE8A92.2040305@tremplin-utc.net>
Date: Tue, 14 Jun 2005 09:43:14 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/2] IDE CD more STANDARD_ATAPI ifdef
References: <42AE09FA.404@tremplin-utc.net> <20050614054947.GC1484@suse.de>
In-Reply-To: <20050614054947.GC1484@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

14.06.2005 07:49, Jens Axboe wrote/a écrit:
> On Tue, Jun 14 2005, Eric Piel wrote:
>>This little patch adds more ifdef's to surround code not necessary for 
>>the standard ATAPI drives. I've tried to find all the code that was 
>>handling special cases. It reduces slightly more the module size :-) As 
>>most of the non standard drives handled seem quite old, this is very safe.
>>
>>This patch has to be applied after my previous patch 
>>(ide-cd-2.6.12-report-current-speed.patch) but I can remake it directly 
>>against latest vanilla kernel if you prefer. BTW, I'd like to make a 
>>Kconfig option for STANDARD_ATAPI, would you accept it?
> 
> 
> To be honest, I'd rather remove the STANDARD_ATAPI ifdef instead. It's
> really not a lot of code, and the ifdefs are just cluttering it up. BTW,
> if we were to honor STANDARD_ATAPI completely (ie strictly follow the
> spec), there would be far more outside of such an ifdef. It's pretty
> much an illusion and hasn't been followed for at least the last 5 years.
> 

Ok. That's a pity though, I discovered this option last week and was so 
happy to reduce the driver size of my little cute standard ATAPI drive 
;-) Well... then let's do the contrary: would accept a patch which 
remove every occurence of STANDARD_ATAPI ? :-)

Eric
