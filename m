Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751966AbWCYXYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbWCYXYY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 18:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbWCYXYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 18:24:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:11216 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751966AbWCYXYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 18:24:24 -0500
Date: Sun, 26 Mar 2006 00:23:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Schwab <schwab@suse.de>
cc: Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Parenthesize macros in xfs
In-Reply-To: <je1wwq2lqn.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.61.0603260023070.12891@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr>
 <20060321082327.B653275@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.61.0603202239110.11933@yvahk01.tjqt.qr>
 <20060321084619.E653275@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.61.0603252232570.18484@yvahk01.tjqt.qr> <je1wwq2lqn.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> -#define swap(a, b)					\
>> +#define swap(a, b) do {					\
>>  	if (swaptype == 0) {				\
>>  		long t = *(long *)(a);			\
>>  		*(long *)(a) = *(long *)(b);		\
>>  		*(long *)(b) = t;			\
>>  	} else						\
>> -		swapfunc(a, b, es, swaptype)
>> +		swapfunc(a, b, es, swaptype)		\
>> +} while(0)
>                                           ^^
>Missing semicolon.
>

It was missing before too. ;)


Jan Engelhardt
-- 
