Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbTCLWRc>; Wed, 12 Mar 2003 17:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262070AbTCLWRc>; Wed, 12 Mar 2003 17:17:32 -0500
Received: from freeside.toyota.com ([63.87.74.7]:35821 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S262067AbTCLWRa>; Wed, 12 Mar 2003 17:17:30 -0500
Message-ID: <3E6FB472.20809@tmsusa.com>
Date: Wed, 12 Mar 2003 14:28:02 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@redhat.com>
Subject: Re: named vs 2.5.64-mm5
References: <3E6F7C78.1040302@tmsusa.com>	 <20030312113126.703de259.akpm@digeo.com> <1047503813.17931.2.camel@rth.ninka.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, the SO_BSDCOMPAT messages are in all
likelihood unrelated to the problems I'm seeing
with bind-9.2.1 under 2.5.6x-recent kernels...

I guess I'll have to turn up the debugging on
bind and see if anything unusual pops up -

Joe

David S. Miller wrote:

>On Wed, 2003-03-12 at 11:31, Andrew Morton wrote:
>  
>
>>The changelog has:
>>
>># --------------------------------------------
>># 03/03/08      jmorris@intercode.com.au        1.1083
>># [NET]: Nuke SO_BSDCOMPAT.
>># --------------------------------------------
>>
>>Maybe James can tell us what is going on here.
>>
>>We should at least place a cap on the number of times that message
>>is printed.
>>    
>>
>
>Feel free to send a patch for that.
>
>SO_BSDCOMPAT has had ZERO side effects since 2.0.x, and it's been
>thus scheduled to be removed for years.  It was merely a binary
>state passed in and out of the kernel to the user and had no effect
>on socket behavior at all.
>
>Any application still referencing this ancient thing either expects
>some kind of different behavior from setting SO_BSDCOMPAT non-zero,
>or really doesn't rely on anything at all.
>
>Since SO_BSDCOMPAT has had zero side effects for 5 or so years, this
>means that the safe change is to remove all references to SO_BSDCOMPAT
>that exist in any application.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


