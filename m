Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbVLVVXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbVLVVXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVLVVXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:23:47 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:32431 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S965182AbVLVVXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:23:47 -0500
Message-ID: <43AB1958.1070407@ru.mvista.com>
Date: Fri, 23 Dec 2005 00:23:36 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, spi-devel-general@sourceforge.net
Subject: Re: [PATCH 2.6-git] SPI: add set_clock() to bitbang
References: <20051222180449.4335a8e6.vwool@ru.mvista.com> <200512220840.34152.david-b@pacbell.net>
In-Reply-To: <200512220840.34152.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Thursday 22 December 2005 7:04 am, Vitaly Wool wrote:
>  
>
>>Hi David,
>>
>>inlined is the small patch that adds set_clock function to the spi_bitbang structure.
>>    
>>
>
>This is actually not needed.  Clocks are set through the setup() method
>in the spi_master, and controller drivers are (courtesy of the library
>approach) free to provide their own.  Drivers for word-at-a-time hardware
>would still need to call spi_bitbang_setup() in their own setup() code,
>to set up the per-device controller_state, and spi_bitbang_cleanup() in
>their own cleanup() code, to deallocate it.
>  
>
Where is it supposed to call setup? I guess it's anyway gonna be 
per-transfer, right?
Or am I missing something?

Vitaly
