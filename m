Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268536AbUHLMpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268536AbUHLMpH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUHLMnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:43:13 -0400
Received: from mail.tmr.com ([216.238.38.203]:33236 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S268536AbUHLMkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:40:31 -0400
Message-ID: <41159975.2080308@tmr.com>
Date: Sat, 07 Aug 2004 23:09:41 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RSS ulimit enforcement for 2.6.8
References: <411299D4.5060001@tmr.com> <Pine.LNX.4.44.0408051647440.8229-100000@dhcp83-102.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408051647440.8229-100000@dhcp83-102.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Thu, 5 Aug 2004, Bill Davidsen wrote:
> 
>>Rik van Riel wrote:
>>
>>>The patch below implements RSS ulimit enforcement for 2.6.8-rc3-mm1.
> 
> 
>>Wish there was something like RSS for cache, so that one process reading 
>>every inode on the planet, or doing an md5 on an 11GB file wouldn't push 
>>every damn process out if it's waiting for me to finish typing a line...
> 
> 
> I guess that's beyond the scope of a simple patch, you may
> be interested in CKRM for something like that:
> 
> 	http://ckrm.sf.net/

Interesting stuff.
> 
> For now I'm just interested in filling out the holes in
> rlimit for the mainline kernel, as well as putting some
> simple resource enforcement things in place.
> 
> I'm not about to add something complex at this stage ;) 
> 
I really wasn't asking that you should, just mumbling and hoping that 
some VM-savvy person would say "I can do that!" and offer an elegant 
solution. Given how little more cache helps for most loads on a machine 
with adequate memory, it seems silly to have almost all the programs on 
a 2GB machine pushed out to make room for pages read exactly once by a 
program copying a 4GB file.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
