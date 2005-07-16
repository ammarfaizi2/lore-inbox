Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVGPTA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVGPTA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 15:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVGPTA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 15:00:29 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:49484 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261154AbVGPTA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 15:00:26 -0400
Date: Sat, 16 Jul 2005 12:58:14 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Volatile vs Non-Volatile Spin Locks on SMP.
In-reply-to: <4qEcy-1CX-21@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42D958C6.7030809@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4q1Ec-5KI-9@gated-at.bofh.it> <4q4sq-7HQ-15@gated-at.bofh.it>
 <4qeLl-7lW-11@gated-at.bofh.it> <4qEcy-1CX-21@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

multisyncfe991@hotmail.com wrote:
> Hello,
> 
> By using volatile keyword for spin lock defined by in spinlock_t, it 
> seems Linux choose to always
> reload the value of spin locks from cache instead of using the content 
> from registers. This may be
> helpful for synchronization between multithreads in a single CPU.
> 
> I use two Xeon cpus with HyperThreading being disabled on both cpus. I 
> think the MESI
> protocol will enforce the cache coherency and update the spin lock value 
> automatically between
> these two cpus. So maybe we don't need to use the volatile any more, right?

The value must always be loaded from memory. If the value is cached in a 
register it will not update when another CPU changes it.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

