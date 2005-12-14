Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVLNRYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVLNRYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVLNRYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:24:12 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:47727 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1750786AbVLNRYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:24:11 -0500
Message-ID: <43A05528.3080801@ru.mvista.com>
Date: Wed, 14 Dec 2005 20:23:52 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <200512131101.02025.david-b@pacbell.net> <439F47F1.1060909@ru.mvista.com> <200512140855.43976.david-b@pacbell.net>
In-Reply-To: <200512140855.43976.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Tuesday 13 December 2005 2:15 pm, Vitaly Wool wrote:
>
>  
>
>>Take for instance spi_w8r8 function used in lotsa places in the drivers 
>>you and Stephen have posted.
>>This function has a) *implicit memcpy* inherited from 
>>spi_write_then_read b) *implicit priority inversion* inherited from the 
>>same place.
>>    
>>
>
>No, (a) is explicit, along with comments not to use that family of
>calls when such things matter more than the convenience of those
>RPC-ish calls.  And (b) was fixed a small patch, now merged.
>  
>
Hmm. Why not use a) when it's convenient? You're placing an artificial 
requirement then.
Yep, saw patch for b). One more kmalloc introduces which can be avoided 
easily with my patch ;)

Vitaly
