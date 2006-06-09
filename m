Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbWFIGGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbWFIGGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 02:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWFIGGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 02:06:18 -0400
Received: from alt.aurema.com ([203.217.18.57]:16791 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S965215AbWFIGGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 02:06:17 -0400
Message-ID: <44890F94.3050209@aurema.com>
Date: Fri, 09 Jun 2006 16:05:08 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
CC: Kirill Korotaev <dev@openvz.org>, Srivatsa <vatsa@in.ibm.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Sam Vilain <sam@vilain.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kingsley Cheung <kingsley@aurema.com>,
       Rene Herman <rene.herman@keyaccess.nl>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [ckrm-tech] [RFC 0/4] sched: Add CPU rate caps (improved)
References: <20060606023708.2801.24804.sendpatchset@heathwren.pw.nest>	<448688B2.2030206@jp.fujitsu.com>	<4487D6B0.3080502@bigpond.net.au>	<4488C765.2050108@aurema.com> <44890C0A.1000005@jp.fujitsu.com>
In-Reply-To: <44890C0A.1000005@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAEDA Naoaki wrote:
> Peter Williams wrote:
>> I've done some informal testing with smaller values of CAP_STATS_OFFSET 
>> and there is only a minor improvement.
>>
>> However, something that does improve behaviour for short lived tasks is 
>> to increase the value of HZ.  This is because the basic unit of CPU
>> allocation by the scheduler is 1/HZ and this is also the minimum time 
>> (and granularity) with which sinbinning and other capping measures can 
>> be implemented.  This is the fundamental limiting factor for the 
>> accuracy of capping i.e. if everything worked perfectly the best 
>> granularity that can be expected from capping of short lived tasks is 
>> 1000 / (HZ * duration) where duration is in seconds.
> 
> I already defines CONFIG_HZ=1000. Do you suggest increasing more?

No.

Peter
-- 
Dr Peter Williams, Chief Scientist         <peterw@aurema.com>
Aurema Pty Limited
Level 2, 130 Elizabeth St, Sydney, NSW 2000, Australia
Tel:+61 2 9698 2322  Fax:+61 2 9699 9174 http://www.aurema.com
