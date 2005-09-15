Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbVIOShw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbVIOShw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 14:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030567AbVIOShw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 14:37:52 -0400
Received: from mail.portrix.net ([212.202.157.208]:38580 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S1030513AbVIOShv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 14:37:51 -0400
Message-ID: <4329BF79.20001@ppp0.net>
Date: Thu, 15 Sep 2005 20:37:45 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Thunderbird/1.0.6 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Knutar <jk-lkml@sci.fi>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc1 load average calculation broken?
References: <43295E30.7030508@ppp0.net> <43296BCE.9020700@ppp0.net> <200509151938.36316.jk-lkml@sci.fi>
In-Reply-To: <200509151938.36316.jk-lkml@sci.fi>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Knutar wrote:
> On Thursday 15 September 2005 15:40, Jan Dittmer wrote:
> 
>>Jan Dittmer wrote:
>>
>>>Get a steady 2.00 there. I stopped unnecessary processes etc.
>>>load average seems to be invariant
>>>
>>>top - 13:41:32 up  4:44,  2 users,  load average: 2.00, 2.00, 2.00
>>>Tasks: 108 total,   2 running, 105 sleeping,   0 stopped,   1 zombie
>>>Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 99.7% id,  0.3% wa,  0.0% hi,  0.0% si
>>
>>Hmm, reboot to 2.6.14-rc1-git1 cured it. Will see if it happens again.
>>(btw. it was not invariant but the lower limit was 2 even after stopping
>>everything but some essential processes (ssh, init, getty))
> 
> 
> Did you check with ps aux, if there were processes stuck in D state? Those
> count towards the load average...

No, I didn't explicitly. But I killed nearly every process but the kernel
threads and it didn't change. Shortly before rebooting the load even rised
again without me doing anything - very creepy (I thought about a rootkit but
the machine just has a NATed ssh port open to the internet on a non-standard
port).
uptime is now 6:32 and it has not happened again.

Jan
