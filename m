Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbTEGJYL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 05:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTEGJYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 05:24:11 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29693 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263021AbTEGJYJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 05:24:09 -0400
Message-ID: <3EB8D36E.10206@mvista.com>
Date: Wed, 07 May 2003 02:35:42 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: akpm@zip.com.au, kbuild-devel@lists.sourceforge.net, mec@shout.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic magic
References: <3EB75924.1080304@mvista.com>	<1052205991.983.13.camel@rth.ninka.net>	<3EB817C9.8020603@mvista.com> <20030506.195511.74729679.davem@redhat.com>
In-Reply-To: <20030506.195511.74729679.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: george anzinger <george@mvista.com>
>    Date: Tue, 06 May 2003 13:15:05 -0700
> 
>    David S. Miller wrote:
>    > This is not at all how this stuff is supposed to work.
>    
>    Um, where might one learn how it is _supposed_ to work?
> 
> By looking at existing uses.
> 
> Some files provide partial APIs, other files are "configured'
> by the asm-ARCH/foo.h header before being included.
> 
Yes, I am aware of existing use.  Sometimes the asm file just includes 
the generic with no additional content.  It is these that go away.
This also means that an arch need not supply the asm version UNTIL it 
has one that does it better.  This might be useful if one wanted to 
supply a u64 = u64 * u32 mpy, for example.  This can be done in C, but 
is rather costly.  An arch could supply the asm version at a later 
time, but for the short haul, the generic gets them on the air.

If the arch wanted to supply only some of the content, the configure 
option as is used with some today, is still available.  CURRENT USAGE 
IS NOT AFFECTED.

As to "_supposed_ to work", I rather though we were making this up as 
we went along, as long as we don't change existing usage, and even, 
sometimes, that rule is not honored :)
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

