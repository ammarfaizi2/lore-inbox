Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbUBYVbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbUBYVaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:30:20 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:10730 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261506AbUBYV1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:27:43 -0500
Message-ID: <403D1347.8090801@matchmail.com>
Date: Wed, 25 Feb 2004 13:27:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403BCE9E.7080607@matchmail.com> <20040224143025.36395730.akpm@osdl.org>
In-Reply-To: <20040224143025.36395730.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm3/
>>
>>Hi,
>>
>>I have 2.6.3 on the 1.5GB RAM server that started the "large slab" thread.
>>
>>Which patches should I apply from -mm to test for improvements?
> 
> 
> Just apply the mm3 rollup patch.

I ended up having to do that. :-/

> 
> 
>>Do these below have any dependencies not listed?
> 
> 
> Probably not.  If they apply ten they'll work.
> 

They won't apply in the order as listed in the -mm3 series file. :(

> 
>>What about Nick's fix up patch for the two patches above?  Should I 
>>include that one also?

I'm running 2.6.3-mm3-486-fazok (nick's patch), and it has improved my 
slab usage greatly.  It was averaging 500MB-700MB slab.  Now slab is 
~230MB, and page cache is ~700MB

See:
http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-memory.html

Is there any way I can get the VM patches against 2.6.3?  I'm not 
comfortable with running -mm3 on this production server, especially 
seeing the "sync hang" bug.

Thanks,

Mike
