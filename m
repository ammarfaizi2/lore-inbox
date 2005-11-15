Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVKOVtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVKOVtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVKOVtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:49:04 -0500
Received: from [195.144.244.147] ([195.144.244.147]:53477 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S1751122AbVKOVtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:49:03 -0500
Message-ID: <437A57CB.8090302@varma-el.com>
Date: Wed, 16 Nov 2005 00:48:59 +0300
From: Andrey Volkov <avolkov@varma-el.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org>
In-Reply-To: <20051115215226.4e6494e0.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Hi Andrey,
> 
> 
>>Possible too late to include in 2.6.15,
>>but better later then never :).
> 
> 
> You must be kidding. It might be too late for 2.6._16_. Reviewing takes
> time, reworking afterwards takes time, then you get some testing in -mm
> and it takes time again.
> 
:((.

> 
>>Comments?
> 
> 
> Sure, although I don't really have the time right now for a complete
> review. And I'd rather not review the code if it finally isn't used.
(see my prev. reply to Andrew and you)

> 
> First, a question. Can't you merge the M41T85 support into the m41t00
> driver?
It was first thing what I try, but this chips are very similar only at
first glance. m41t85 have _really_ extended sets of regs and result was
very littered by #if/#else file.

> 
> Mark, care to comment on that possibility, and/or on the code itself?
> 
And, please, remove unnecessary PPC dependence from Kconfig.

>>+config SENSORS_M41T85_SQW_FRQ_ENABLE
>>+	depends on SENSORS_M41T85
>>+	bool "Square Wave Output"
> 
> 
> What a mess. Please just have a sysfs file for that, it's more flexible
> and less intrusive.

I agree, it's look messed, but if sombody use SQW,
then must exist some startup constant for some custom board.
Changing this frq may exist only as option.

--
Regards
Andrey Volkov
