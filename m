Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbTHYDhL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 23:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbTHYDhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 23:37:11 -0400
Received: from dyn-ctb-210-9-243-120.webone.com.au ([210.9.243.120]:21252 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261447AbTHYDhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 23:37:07 -0400
Message-ID: <3F498439.60102@cyberone.com.au>
Date: Mon, 25 Aug 2003 13:36:25 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Nick's scheduler policy
References: <3F48B12F.4070001@cyberone.com.au> <34251.4.4.25.4.1061782057.squirrel@www.osdl.org>
In-Reply-To: <34251.4.4.25.4.1061782057.squirrel@www.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Randy.Dunlap wrote:

>>Hi,
>>Patch against 2.6.0-test4. It fixes a lot of problems here vs
>>previous versions. There aren't really any open issues for me, so
>>testers would be welcome.
>>
>>
>...
>
>>On the other hand, I expect the best cases and maybe most usual cases would
>>be better on Con's... and Con might have since done some work in the latency
>>area.
>>
>
>Has anyone developed a (run-time) scheduler [policy] selector, via
>sysctl or sysfs, so that different kernel builds aren't required?
>
>I know that I have heard discussions of this previously.
>

Not that I know of. This would probably require an extra layer of
indirection in the standard form of Linux's struct of pointers to
functions, with your standard schedule functions as wrappers.
I think it would be highly unlikely that this would get into a
standard kernel, but might make a nice testing tool...

In fact this might end up being incompatible with architectures
like SPARC... but I'm sure someone could make it work if they really
wanted to.

I think the present boot-time selector (selecting different kernels
at boot) will have to suffice for now :P


