Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbTLaXPc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 18:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbTLaXPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 18:15:32 -0500
Received: from kiy.wanderer.org ([195.218.87.138]:25613 "EHLO kiy.wanderer.org")
	by vger.kernel.org with ESMTP id S265282AbTLaXPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 18:15:31 -0500
Message-ID: <3FF34522.8060106@tv.debian.net>
Date: Wed, 31 Dec 2003 23:52:34 +0200
From: Tommi Virtanen <tv@tv.debian.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Love <rml@ximian.com>
Cc: Nathan Conrad <lk@bungled.net>, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local>	 <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur>	 <20031231220107.GC11032@bungled.net> <1072909218.11003.24.camel@fur>	 <3FF3436A.7050503@tv.debian.net> <1072912256.11003.30.camel@fur>
In-Reply-To: <1072912256.11003.30.camel@fur>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Love wrote:
>>Let me try to rephrase Nathan's question more explicitly.
>>
>>If user policy decides all naming, how does the kernel parse e.g. 
>>root=/dev/foo arguments? Or the swap partition to use for swsuspend?
> Oh.  That has always been a hack, ala name_to_dev_t().
> 
> We will have to continue doing that hack so long as those users are in
> the kernel proper (and not early user-space, for example).

I think devfs names are accepted as root= arguments, so that's a bit of
a loss.. with udev, your /dev and your root= are equal only if you
follow the standard naming.

For root=, I can see how early userspace can move that to userspace.
But what about swsuspend?

Are there any more kernel options taking file names? I think now would
be a good time to stop adding more of them :)

