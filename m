Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVDMJGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVDMJGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVDMJGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:06:35 -0400
Received: from terminus.zytor.com ([209.128.68.124]:26296 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261270AbVDMJGU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:06:20 -0400
Message-ID: <425CE11C.8040306@zytor.com>
Date: Wed, 13 Apr 2005 02:06:36 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Baudis <pasky@ucw.cz>
CC: David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] git-pasky-0.3
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz> <1113311256.20848.47.camel@hades.cambridge.redhat.com> <20050413094705.B1798@flint.arm.linux.org.uk> <20050413085954.GA13251@pasky.ji.cz>
In-Reply-To: <20050413085954.GA13251@pasky.ji.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Wed, Apr 13, 2005 at 10:47:05AM CEST, I got a letter
> where Russell King <rmk+lkml@arm.linux.org.uk> told me that...
> 
>>On Tue, Apr 12, 2005 at 02:07:36PM +0100, David Woodhouse wrote:
>>
>>>I'd suggest making it [index] big-endian to make sure the LE weenies don't
>>>forget to byteswap properly.
>>
>>That's not a bad argument actually - especially as networking uses BE.
>>(and git is about networking, right?) 8)
> 
> Theoretically, you are never supposed to share your index if you work in
> fully git environment. However, I offer some "base tarballs" which have
> the unpacked source as well as the .git directory, and I think you want
> the index there. Of course you can always regenerate it by
> 
> 	read-tree $(tree-id)
> 
> but I really don't want to (hey, dwmw got away with that too! ;-). It
> forces an additional out-of-order step you need to do before making use
> of your git for the first time.
> 
> The NFS argument obviously seems perfectly valid to me too.  So, FWIW,
> I'm personally all for it, if someone gives me a patch.
> 

In userspace, it's definitely easier to stick with BE for a standard 
byte order, simply because it's the one byteorder one can rely on there 
being macros available to deal with on all platforms.

However, then I would also like to suggest replacing "unsigned int" and 
"unsigned short" with uint32_t and uint16_t, even though they're 
consistent on all *current* Linux platforms.

	-hpa
