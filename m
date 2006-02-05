Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWBEOzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWBEOzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 09:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWBEOzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 09:55:15 -0500
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:4056 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S1750732AbWBEOzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 09:55:14 -0500
Message-ID: <43E61145.6080707@sw.ru>
Date: Sun, 05 Feb 2006 17:52:53 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Do you have any other ideas/comments on this?
>> I will send additional IPC/filesystems virtualization patches a bit later.
> 
> I think that a patch like this - particularly just the 1/5 part - makes 
> total sense, because regardless of any other details of virtualization, 
> every single scheme is going to need this.
> 
> So I think at least 1/5 (and quite frankly, 2-3/5 look that way too) are 
> things that we can (and probably should) merge quickly, so that people can 
> then actually look at the differences in the places that they may actually 
> disagree about.
Can we merge also proc/sysfs/network/netfilters virtualization?

> In other words, I personally would have called them "container" or 
> something similar, rather than "vps_info". See? From a logical 
> implementation standpoint, the fact that it is right now most commonly 
> used for VPS hosting is totally irrelevant to the code, no?
> 
> (And hey, maybe your "vps" means something different. In which case my 
> argument makes even more sense ;)
virtual private sandbox :)

Actually, we call them "virtual environments" (VE) in OpenVZ. It is more 
than abstract and have a nice brief name. If this suits you - I will be 
happy to commit patches as is :)

other variants:
virtual context (vc, vctx),
virtual containers (vc).

I personally don't like "container", since it is too long and I see no 
good abreviations for this...

Kirill

