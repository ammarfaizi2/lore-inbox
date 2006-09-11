Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWIKVEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWIKVEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWIKVEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:04:43 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:37139 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S964991AbWIKVEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:04:42 -0400
Message-ID: <4505CF71.1070605@cfl.rr.com>
Date: Mon, 11 Sep 2006 17:04:49 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Segfault Error - what does this mean?
References: <4505B788.1030803@perkel.com>
In-Reply-To: <4505B788.1030803@perkel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2006 21:04:52.0560 (UTC) FILETIME=[ECE9A500:01C6D5E5]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14686.000
X-TM-AS-Result: No--26.116500-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A segfault means the program tried to touch a part of memory in a way 
that it is not allowed.  In this case, the address was 0, which would 
indicate that exim attempted to dereference a null pointer.  It would 
appear this is a bug in exim, not the kernel.

Marc Perkel wrote:
> Just put a new server online trying out the new AMD AM2 processor. I 
> compiled a custom kernel because the regular Fedora Core kernels aren't 
> yet compatible with my Asus M2NPV-VM motherboard using the nVidia chipset.
> 
> I compiled 2.6.18rc6 and got segfault errors. So I tried the 2.6.17.13 
> kernel and same thing. About every 20 minutes or so I get one of these.
> 
> Sep 11 12:05:18 pascal kernel: exim[19840]: segfault at 0000000000000000 
> rip 0000003f53e73ee0 rsp 00007fff9e561d18 error 4
> 
> At one point the server locked up. Before I put it online I did several 
> days of memory testing with no errors. I believe the Exim code is solid 
> as it has been running flawlessly on all my other servers.
> 
> It's probably hardware or some incompatibility but I'm not sure where to 
> start looking. Trying to understand what this error means. What is Error 
> 4? How do I track this down?
> 
> Thanks in advance.
> 

