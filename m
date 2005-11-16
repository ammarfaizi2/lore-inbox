Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbVKPOpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbVKPOpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbVKPOpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:45:49 -0500
Received: from [195.144.244.147] ([195.144.244.147]:12933 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S1030348AbVKPOpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:45:49 -0500
Message-ID: <437B4619.6050805@varma-el.com>
Date: Wed, 16 Nov 2005 17:45:45 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <20051116025714.GK5546@mag.az.mvista.com>
In-Reply-To: <20051116025714.GK5546@mag.az.mvista.com>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=pgp.dtype.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mark A. Greer wrote:
> Hi Jean,
> 
> On Tue, Nov 15, 2005 at 09:52:26PM +0100, Jean Delvare wrote:
> 
> <snip>
> 
>>First, a question. Can't you merge the M41T85 support into the m41t00
>>driver?
>>
>>Mark, care to comment on that possibility, and/or on the code itself?
> 
> 
> Sure.
> 
> I wrestled with the ST website for the m41t85 datasheet but lost so I
> I can only guess from the patch.  The drivers do look very similar.
> It looks like the m41t85 is basically a m41t00 with an alarm (watchdog
> timer never used AFAICT).  
http://www.st.com/stonline/products/literature/ds/7531/m41st85w.pdf
(I agree ST's (and Maxim's too) site is for strength of mind men :) ).
Also added onchip clock, battery and poweroff time
(HT == Halt Timestamp).

> Also there are some differences in register
> offsets and [maybe] some minor differences within the registers but
> nothing that serious.
Mainly you're right, but, as I wrote before, due to _many_ little
differences I get #if/#else.. noise (half file, if be more precisely,
was under #if/#else) in unified file. But, if this noise
will be acceptable, then yes, I agree to merge this drivers, as minimum,
for better administration.

<snip>

-- 
Regards
Andrey Volkov
