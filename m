Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUD2Ana@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUD2Ana (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUD2Ana
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:43:30 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:37302 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261347AbUD2An3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:43:29 -0400
Message-ID: <40904FAE.10709@yahoo.com.au>
Date: Thu, 29 Apr 2004 10:43:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: brettspamacct@fastclick.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <4090467E.4070709@fastclick.com> <409048B7.1000103@pobox.com>
In-Reply-To: <409048B7.1000103@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Brett E. wrote:
> 
>> exits, freeing up the malloc'ed memory. This brings free memory up by 
>> 400 megs and brings the cache down to close to 0, of course the cache 
> 
> 
> Yeah, I have something similar (attached).  Run it like
> 
>     fillmem <number-of-megabytes>
> 
> 
>> grows right afterwards. It would be nice to cap the cache 
>> datastructures in the kernel but I've been posting about this since 
>> September to no avail so my expectations are pretty low.
> 
> 
> This is a frequent request...  although I disagree with a hard cap on 
> the cache, I think the request (and similar ones) should hopefully 
> indicate to the VM gurus that the kernel likes cache better than anon 
> VMAs that must be swapped out.
> 

For 2.6.6-rc2-mm2:
http://www.kerneltrap.org/~npiggin/vm-rollup.patch.gz

/proc/sys/vm/mapped_page_cost - indicate which *you* like better ;)
