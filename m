Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWASD2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWASD2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWASD2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:28:49 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:37255 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S964871AbWASD2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:28:48 -0500
Message-ID: <43CF0768.60703@candelatech.com>
Date: Wed, 18 Jan 2006 19:28:40 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can you specify a local IP or Interface to be used on a	per	NFS
 mount basis?
References: <43CECB00.40405@candelatech.com>	 <1137631728.13076.1.camel@lade.trondhjem.org>	 <43CEF7A6.30802@candelatech.com> <1137641084.8864.3.camel@lade.trondhjem.org>
In-Reply-To: <1137641084.8864.3.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Wed, 2006-01-18 at 18:21 -0800, Ben Greear wrote:
> 
> 
>>>NFS doesn't know anything about ip packet routing. That is a networking
>>>issue.
>>
>>When a socket is created, you can optionally bind to local IP, interface and/or
>>IP-Port.  Somewhere, NFS is opening a socket I assume?  So, is there a way to
>>ask it to bind?
> 
> 
> 
> As David said, the place to fix it is in xs_bindresvport(), but there is
> no support for passing this sort of information through the current NFS
> binary mount structure. You would have to hack that up yourself.

I can think of some horrible hacks to grab info out of a text file based
on the mount point or some other available info...but if I actually
attempted to do it right..would you consider the patch for kernel
inclusion?  Is it OK to modify the binary mount structure?

Ben

> 
> Cheers,
>   Trond
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

