Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWIRNnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWIRNnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWIRNnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:43:01 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:6825 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751570AbWIRNnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:43:00 -0400
Message-ID: <450EA198.5060302@aitel.hist.no>
Date: Mon, 18 Sep 2006 15:39:36 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: yogeshwar sonawane <yogyas@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How much kernel memory is in 64-bit OS ?
References: <b681c62b0609160434g6ccbbaa0vd0cd68958696726e@mail.gmail.com> <b681c62b0609180251m79071e59oe212b1133bf6944c@mail.gmail.com>
In-Reply-To: <b681c62b0609180251m79071e59oe212b1133bf6944c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yogeshwar sonawane wrote:
> On 9/16/06, yogeshwar sonawane <yogyas@gmail.com> wrote:
>> Hi all,
>>
>> We all know that in 32-bit OS, total 4GB memory space is divided in
>> 3(user) + 1(kernel) space.
>>
>> Similarly, what is the division/scenario in case of 64-bit OS ?
>>
>> Any reference/explanation will be helpful.
>>
>> thanks in advance.
>>
>>
>> Yogeshwar
>>
>
> On similar lines, some time back, i read that, to accomodate large
> physical memory ,
> the 3G/1G layout is modified to have 4G/4G partition. But if somebody
> can focus the light on following things, it will be helpful.
> 1) what was the requirement of 4G/4G layout ?
It offers more memory than 3G/1G.  This is an improvement, so of
course it is the chosen way. It was not required - you sure can use
a 3G/1G split on a 64-bit processor - but why introduce an artifical
limitation?

The requirement for using a 4G/4G split is to have a processor
that support 64-bit adressing as well as 32-bit backward compatibility.
> 2) how it is managed ?
The kernel runs in 64-bit mode, offering the 4G/4G stuff for 32-bit 
processes.

> 3) how HIGH_MEMORY concept is related here.
high memory is a quirky way of supporting more than 4G on a 32-bit
processor.  A 64-bit processor support much more than 4G, so no need
for tricks that work around the limitations of 32-bit processors.


Helge Hafting
