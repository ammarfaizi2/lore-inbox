Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWEBL0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWEBL0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 07:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWEBL0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 07:26:49 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:34569 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S964774AbWEBL0s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 07:26:48 -0400
Message-ID: <445741F5.6060204@argo.co.il>
Date: Tue, 02 May 2006 14:26:45 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Willy Tarreau <willy@w.ods.org>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <mj+md-20060502.111446.9373.atrey@ucw.cz>
In-Reply-To: <mj+md-20060502.111446.9373.atrey@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2006 11:26:46.0617 (UTC) FILETIME=[4BF3C490:01C66DDB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> Hello!
>
>   
>> Perhaps people who developed kernel-level code in _both_ C and C++ would 
>> be qualified to speculate on that (I have, but apparently I don't have a 
>> clue).
>>     
>
> Well, what about just showing an example of kernel code in C++, which
> you consider nice?
>   

I don't have access to that code (which was closed source anyway).

But it executed C++ code within a few cycles of entering the reset 
vector (no standard BIOS), including but not limited to: programming the 
memory controller (430MX chipset), servicing interrupts, hardware 
accelerated 2D graphics (C&T 65550), IDE driver, simple filesystem, 
simple windowing GUI, network driver (Tulip) etc.

More recently I participated in writing a filesystem in C++. That's in 
userspace, but many of the techniques used in writing kernel code are 
necessary there (extreme robustness, can't assume infinite memory, 
locking, etc.)

There are C++ embedded kernels in http://www.zipworld.com.au/~akpm/ and 
http://ecos.sourceware.org/, but I haven't looked at them, so I can't 
say whether I consider them nice or not.

-- 
error compiling committee.c: too many arguments to function

