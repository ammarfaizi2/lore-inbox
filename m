Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVC0WNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVC0WNI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 17:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVC0WNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 17:13:08 -0500
Received: from alog0136.analogic.com ([208.224.220.151]:36065 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261595AbVC0WNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 17:13:04 -0500
Date: Sun, 27 Mar 2005 17:12:07 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Marcin Dalecki <martin@dalecki.de>
cc: ext2-devel@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <7d96f2772f942f802890c50801c4f5f8@dalecki.de>
Message-ID: <Pine.LNX.4.61.0503271708500.17365@chaos.analogic.com>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
 <1111825958.6293.28.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
 <7d96f2772f942f802890c50801c4f5f8@dalecki.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, Marcin Dalecki wrote:

>
> On 2005-03-27, at 00:21, linux-os wrote:
>>
>> Always, always, a call will be more expensive than a branch
>> on condition. It's impossible to be otherwise. A call requires
>> that the return address be written to memory (the stack),
>> using register indirection (the stack-pointer).
>>
> Needless to say that there are enough architectures out there, which
> don't even
> have something like an explicit call as separate assembler
> instruction...
>

Yes, they break the 'call' into seperate expensive operations like
loading the IP address that will exist after the call into a register
storing that in a dedicated register, used as a "stack", then
branching to the called procedure with another indirection, etc.

>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
