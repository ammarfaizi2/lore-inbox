Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTJNKWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 06:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTJNKWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 06:22:12 -0400
Received: from dyn-ctb-210-9-243-42.webone.com.au ([210.9.243.42]:46596 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262128AbTJNKWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 06:22:07 -0400
Message-ID: <3F8BCAB3.2070609@cyberone.com.au>
Date: Tue, 14 Oct 2003 20:06:43 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Piet Delaney <piet@www.piet.net>, George Anzinger <george@mvista.com>,
       Clayton Weaver <cgweav@email.com>, linux-kernel@vger.kernel.org
Subject: Re: Circular Convolution scheduler
References: <20031006161733.24441.qmail@email.com> <3F833C06.7000802@mvista.com> <1066120643.25020.121.camel@www.piet.net> <20031014094655.GC24812@mail.shareable.org>
In-Reply-To: <20031014094655.GC24812@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jamie Lokier wrote:

>Piet Delaney wrote:
>
>>circular convolution is used with the Fast Fourier Transform.
>>The frequency data goes from -N/2 ...0 ,,,, +N/2,
>>multiplying in the frequency domain is the same as
>>convolving in the time or space domain. The result of multiplying
>>a time series by say a filter is the same as convolving it
>>with the FFT of the filter. Both domains wrap around with the
>>FFT, so the normal convolution associated with the Fourier
>>transform is replace with the circular convolution.
>>
>>Many prediction algorithms are based on digital signal processing.
>>The Kalman filter for example was used by Harvey for forecasting
>>financial markets. The kernel likely has lots of time series that
>>could be used for system identification for predicting how to best
>>use system resources.
>>
>
>Ok, but what is "circular convolution scheduling"?
>
>

I don't know anything about it, but I don't see what exactly you'd be
trying to predict: the kernel's scheduler _dictates_ scheduling behaviour,
obviously. Also, "best use of system resources" wrt scheduling is a big
ask considering there isn't one ideal scheduling pattern for all but the
most trivial loads, even on a single processor computer (fairness, latency,
priority, thoughput, etc). Its difficult to even say one pattern is better
than another.


