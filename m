Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVLNTfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVLNTfH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVLNTfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:35:07 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:46960 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S932254AbVLNTfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:35:02 -0500
Message-ID: <43A073D4.3060406@ru.mvista.com>
Date: Wed, 14 Dec 2005 22:34:44 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051214171842.GB30546@kroah.com> <43A05C32.3070501@ru.mvista.com> <200512141102.53599.david-b@pacbell.net>
In-Reply-To: <200512141102.53599.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Wednesday 14 December 2005 9:53 am, Vitaly Wool wrote:
>
>  
>
>>	 Sound cards behind the SPI bus will suffer a lot more 
>>since it's their path to use wXrY functions (lotsa small transfers) 
>>rather than WLAN's.
>>    
>>
>
>No, "stupid drivers will suffer"; nothing new.  Just observe
>how the ads7846 touchscreen driver does small async transfers.
>  
>
Two more cents: ads7846 has a bunch of code just related to the need to 
do something from the interrupt context. Without this constraint, I 
don't see why w8r8 can not be used in most cases (of course, with the 
changes I propose).

Vitaly
