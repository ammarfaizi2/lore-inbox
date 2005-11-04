Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030595AbVKDEBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030595AbVKDEBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030596AbVKDEBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:01:20 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:18153 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1030595AbVKDEBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:01:19 -0500
Message-ID: <436ADD1E.9080907@m1k.net>
Date: Thu, 03 Nov 2005 23:01:34 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 04/37] dvb: Add ATSC support for DViCO FusionHDTV5 Lite
References: <4367236E.90008@m1k.net> <20051103132914.64e971b9.akpm@osdl.org>
In-Reply-To: <20051103132914.64e971b9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Michael Krufky <mkrufky@m1k.net> wrote:
>  
>
>>+static int tdvs_tua6034_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
>> +{
>> +	struct dvb_bt8xx_card *card = (struct dvb_bt8xx_card *) fe->dvb->priv;
>>    
>>
>
>The cast of a void* is unneeded.  It's actually undesirable: if someone
>were to convert the thing-being-casted to some other scalar type, the cast
>would prevent the desired compiler warning.
>
Alexey Dobriyan wrote:

>Please, also
>
>	struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
>			   ^				       ^
>
Both of these problems are all over dvb-kernel... We'll fix it up.

Thanks,

Michael Krufky
