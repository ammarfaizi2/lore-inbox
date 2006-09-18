Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWIRQNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWIRQNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbWIRQNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:13:25 -0400
Received: from smtp104.biz.mail.mud.yahoo.com ([68.142.200.252]:35173 "HELO
	smtp104.biz.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964833AbWIRQNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:13:24 -0400
In-Reply-To: <1158590004.8239.14.camel@localhost.localdomain>
References: <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com> <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com> <20060911225617.GB13474@elf.ucw.cz> <20060912001701.GC14234@linux.intel.com> <20060912033700.GD27397@kroah.com> <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com> <20060914055529.GA18031@kroah.com> <b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com> <20060917174835.GA2225@elf.ucw.cz> <1158590004.8239.14.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3624e4a9b11b308693d6fb56551ab5a5@nomadgs.com>
Content-Transfer-Encoding: 7bit
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org,
       kernel list <linux-kernel@vger.kernel.org>
From: Matthew Locke <matt@nomadgs.com>
Subject: Re: [linux-pm] OpPoint summary
Date: Mon, 18 Sep 2006 09:13:22 -0700
To: "Richard A. Griffiths" <richard.griffiths@windriver.com>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sep 18, 2006, at 7:33 AM, Richard A. Griffiths wrote:

> On Sun, 2006-09-17 at 19:48 +0200, Pavel Machek wrote:
>> Hi!
>>
>>>> Care to resend your patches in the proper format, through email so 
>>>> that
>>>> we can see them, and possibly get some testing in -mm if they look 
>>>> sane?
>>>
>>> Greg,
>>>   here's the patch that implements operating points for different
>>>   frequencies
>>> for the speedstep-centrino line of processors.  Operating points are 
>>> created
>>> in much the same manner that cpufreq tables are.  This works for both
>>> simple implementations like the centrino and more complex SoC systems
>>> like the arm-pxa72x which has several clocks to control, and 
>>> different clock
>>> divisors and multipliers.
>>
>>> +static struct oppoint lowest = {
>>> +       .name = "lowest",
>>> +       .type = PM_FREQ_CHANGE,
>>> +       .frequency = 0,
>>> +       .voltage = 0,
>>> +       .latency = 15,
>>> +       .prepare_transition  = cpufreq_prepare_transition,
>>> +       .transition = centrino_transition,
>>> +       .finish_transition = cpufreq_finish_transition,
>>> +};
>>
>> We had nice, descriptive interface... with numbers. Now you want to
>> introduce english state names... looks like a step back to me.
>
> Maybe a compromise could be reached where a defined set of numbers maps
> to  string names ala Unix init states. Many people (at least me) still
> invoke init 6 to reboot a system.  A defined table would satisfy both
> the number and string camps.

PowerOP allows the platform to define the name. In our cpufreq 
integration patches, we reuse the same name that cpufreq centrino used.

>
> Richard
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>

