Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbUKNN4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbUKNN4j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 08:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbUKNN4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 08:56:39 -0500
Received: from relay01.pair.com ([209.68.5.15]:29970 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261303AbUKNN4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 08:56:37 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <419763F0.8090101@cybsft.com>
Date: Sun, 14 Nov 2004 07:56:00 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Florian Schmidt <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
References: <20041022155048.GA16240@elte.hu>	<20041022175633.GA1864@elte.hu>	<20041025104023.GA1960@elte.hu>	<20041027001542.GA29295@elte.hu>	<20041103105840.GA3992@elte.hu>	<20041106155720.GA14950@elte.hu>	<20041108091619.GA9897@elte.hu>	<20041108165718.GA7741@elte.hu>	<20041109160544.GA28242@elte.hu>	<20041111144414.GA8881@elte.hu>	<20041111215122.GA5885@elte.hu> <20041114135656.7aa3b95b@mango.fruits.de> <41975D16.3050402@cybsft.com>
In-Reply-To: <41975D16.3050402@cybsft.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
> Florian Schmidt wrote:
> 
>> On Thu, 11 Nov 2004 22:51:22 +0100
>> Ingo Molnar <mingo@elte.hu> wrote:
>>
>>
>>> i have released the -V0.7.25-1 Real-Time Preemption patch, which can be
>>> downloaded from the usual place:
>>>
>>>    http://redhat.com/~mingo/realtime-preempt/
>>
>>
>>
>> Hi,
>>
>> i just build and booted into 26-3 (w/o debugging stuff) and put a little
>> load on the system (find /'s plus kernel compile plus rtc_wakeup -f 
>> 8192).
>> Got this on the console:
>>
>> `IRQ 8` [14] is being piggy. need_resched=0, cpu=0
>>
>> and the machine locked. will build with debugging and try to reproduce.
>>
>> flo
>>
> 
> Did you get any other messages in the log? This message is harmless as 
> far as the machine locking. This gets printed from rtc when a read of 
> /dev/rtc is missed before another interrupt arrives.
> 
> kr

Actually this message should probably be removed, because the only 
process that will every show up as being a piggy anymore will be 'IRQ 
8', right?

kr
