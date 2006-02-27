Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWB0Iio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWB0Iio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWB0Iio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:38:44 -0500
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:46129 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932306AbWB0Iio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:38:44 -0500
Date: Mon, 27 Feb 2006 03:38:43 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 4/7] Add sysctl for delay accounting
In-reply-to: <1141028784.2992.58.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Message-id: <4402BA93.5010302@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <1141026996.5785.38.camel@elinux04.optonline.net>
 <1141028322.5785.60.camel@elinux04.optonline.net>
 <1141028784.2992.58.camel@laptopd505.fenrus.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>+/* Allocate task_delay_info for all tasks without one */
>>+static int alloc_delays(void)
>>    
>>
>
>I'm sorry but this function seems to be highly horrible
>  
>
Could you be more specific ? Is it the way its coded or the design 
(preallocate, then assign)
itself ?

The function needs to allocate task_delay_info structs for all tasks 
that might
have been forked since the last time delay accounting was turned off.
Either we have to count how many such tasks there are, or preallocate
nr_tasks (as an upper bound) and then use as many as needed.

Thanks for reviewing so quickly.
-- Shailabh


