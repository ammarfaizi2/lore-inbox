Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVLNTbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVLNTbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVLNTbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:31:09 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:43632 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S932400AbVLNTbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:31:07 -0500
Message-ID: <43A072EA.70603@ru.mvista.com>
Date: Wed, 14 Dec 2005 22:30:50 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com> <20051213195317.29cfd34a.vwool@ru.mvista.com> <200512131101.02025.david-b@pacbell.net> <20051213191531.GA13751@kroah.com> <43A0230B.1040904@ru.mvista.com> <20051214171842.GB30546@kroah.com> <43A05C32.3070501@ru.mvista.com> <20051214191642.GA31838@kroah.com>
In-Reply-To: <20051214191642.GA31838@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Wed, Dec 14, 2005 at 08:53:54PM +0300, Vitaly Wool wrote:
>  
>
>>Greg KH wrote:
>>
>>    
>>
>>>What is the speed of your SPI bus?
>>>
>>>And what are your preformance requirements?
>>>
>>>
>>>      
>>>
>>The maximum frequency for the SPI bus is 26 MHz, WLAN driver is to work 
>>at true 10 Mbit/sec.
>>    
>>
>
>Then you should be fine with the copying data and memset stuff, based on
>the workload the rest of the kernel does for other busses which have
>this same requirement of DMAable buffers.
>
>And I'm sure David will be glad to have you point out any places in his
>code where it accidentally takes data off of the stack instead of
>allocating it.
>  
>
Hmm, I recall I've already posted some pieces of code with that stuff.

Vitaly

