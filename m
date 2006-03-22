Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWCVTMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWCVTMW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWCVTMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:12:22 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:34315 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932358AbWCVTMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:12:21 -0500
Message-ID: <4421A18F.4040600@argo.co.il>
Date: Wed, 22 Mar 2006 21:12:15 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: john stultz <johnstul@us.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is
 default
References: <20060320122449.GA29718@outpost.ds9a.nl>	<20060320145047.GA12332@rhlx01.fht-esslingen.de>	<200603210224.23540.kernel@kolivas.org>	<87wteo37vr.fsf@duaron.myhome.or.jp>	<1142968999.4281.4.camel@leatherman> <8764m7xzqg.fsf@duaron.myhome.or.jp>
In-Reply-To: <8764m7xzqg.fsf@duaron.myhome.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2006 19:12:19.0615 (UTC) FILETIME=[8A6142F0:01C64DE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> john stultz <johnstul@us.ibm.com> writes:
>
>   
>> In my TOD rework I've dropped the triple read, figuring if a problem
>> arose we could blacklist the specific box. This patch covers that, so it
>> looks like a good idea to me.
>>
>> I've not tested it myself, but if you feel good about it, please send it
>> to Andrew.
>>     
>
> Current patch is the following. If I'm missing something, or you have
> some comment, please tell me. (Since I don't have ICH4, ICH4 detection
> is untested)
>   
Doesn't it make sense to mark the port as user accessible in the I/O 
permissions bitmap and export it as a vsyscall? that would save the 
syscall overhead.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

