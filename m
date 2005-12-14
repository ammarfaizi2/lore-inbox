Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVLNLSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVLNLSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVLNLSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:18:01 -0500
Received: from smtp104.plus.mail.mud.yahoo.com ([68.142.206.237]:41305 "HELO
	smtp104.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932399AbVLNLSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:18:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iaj7s4UzAm3sIkXL7tR9DRfnSGMf3bJLn/Xu0jtTo7awsvffV/dNOzvPFzX6UooRlLpnFtH8QLiFIhsbqk04aO/J4rTVkwIvcLsqA/Yufkzyu6XdwNTJTDxpwAq40gs8Wo5WvANm6wT+CBtU5SMZn1o25NxWy/V5vWPhSqk+zsE=  ;
Message-ID: <439FFF63.6020105@yahoo.com.au>
Date: Wed, 14 Dec 2005 22:17:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <439F6EAB.6030903@yahoo.com.au>  <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <13613.1134557656@warthog.cambridge.redhat.com>
In-Reply-To: <13613.1134557656@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>atomic_cmpxchg should be available on all platforms.
> 
> 
> Two points:
> 
>  (1) If it's using spinlocks, then it's pointless to use atomic_cmpxchg.
> 

Why?

>  (2) atomic_t is a 32-bit type, and on a 64-bit platform I will want a 64-bit
>      type so that I can stick the owner address in there (I've got a second
>      variant not yet released).
> 

I'm sure you could use a seperate field as it would be a debug
option, right?

But atomic longs are coming along and it is probably feasable to
do 64-bit atomic_cmpxchg on all 64-bit word architectures if you
really needed that.

Send instant messages to your online friends http://au.messenger.yahoo.com 
