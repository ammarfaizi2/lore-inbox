Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422810AbWJNS5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWJNS5T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbWJNS5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:57:19 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:31144 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1422810AbWJNS5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:57:18 -0400
Message-ID: <45313306.104@linuxtv.org>
Date: Sat, 14 Oct 2006 14:57:10 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: mchehab@infradead.org, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH 08/18] V4L/DVB (4734): Tda826x: fix frontend selection
 for dvb_attach
References: <20061014115356.PS36551000000@infradead.org> <20061014120050.PS78628900008@infradead.org> <20061014121608.GN30596@stusta.de> <45312819.4080909@linuxtv.org> <20061014183322.GS30596@stusta.de>
In-Reply-To: <20061014183322.GS30596@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Sat, Oct 14, 2006 at 02:10:33PM -0400, Michael Krufky wrote:
>  
>
>>>This breaks with CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA826X=m.
>>>      
>>>
>>Regardless, the patch must be applied.  The above should only break with DVB_FE_CUSTOMIZE=Y ...
>>
>>Turn off DVB_FE_CUSTOMIZE, and you will find that the above does NOT break.  You can probably reproduce this 'broken' situation by setting any card driver = y, with the frontend = m ...
>>
>>As stated in the prior thread, "CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA826X=m" is not the problem -- rather, "CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA826X=m, DVB_FE_CUSTOMIZE=Y" causes the breakage.
>>    
>>
>This patch fixes only a part of the problem.
>
>If this is the way how you want to handle CONFIG_DVB_FE_CUSTOMIZE=y, 
>I don't understand why you don't use
>  #if defined(CONFIG_DVB_TDA826X) || (defined(CONFIG_DVB_TDA826X_MODULE) && defined(MODULE))
>which is what I stated in exactly the thread you quote.
>  
>
Adrian --

Two separate problems, please do not confuse them.

My tda10086 and tda826x patches are correct -- there is no question of it.

I did not get an email from you with a suggestion for a fix for 
DVB_FE_CUSTOMIZE, but my cable / internet has been down for a day and a 
half, maybe it will come in soon.

I am not the author of DVB_FE_CUSTOMIZE, adq (cc added) seems to be busy 
at the moment.  Please send in your patch suggestion to the 
v4l-dvb-maintainer list, if you haven't already, and we can discuss that 
issue separately.

-Mike Krufky

