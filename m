Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263865AbUGMEQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUGMEQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 00:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbUGMEQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 00:16:27 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:23789 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S263865AbUGMEQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 00:16:25 -0400
Message-ID: <40F36216.1080603@metaparadigm.com>
Date: Tue, 13 Jul 2004 12:16:22 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Lutz Vieweg <lkv@isg.de>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: How to find out which pages were copied-on-write?
References: <40EACC0C.6060606@isg.de> <20040709113125.GA8897@lnx-holt.americas.sgi.com> <40EF0346.4040407@isg.de> <40EFA4C8.1050409@metaparadigm.com> <40F2C882.7070406@isg.de>
In-Reply-To: <40F2C882.7070406@isg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/04 01:21, Lutz Vieweg wrote:
> Michael Clark wrote:
> 
>> HPAs library LPSM sounds like what you're looking for.
>>
>> http://freshmeat.net/projects/lpsm/
>>
>> Or you can do what you want the hard way using mprotect and a SEGV 
>> handler.
> 
> 
> Certainly a valid idea to consider - doing all those things in 
> userspace... so
> thanks for the hint!
> 
> But wouldn't that introduce a significant overhead and undermine all of the
> nice advantages the kernel might have in scheduling I/O operations?

Not really. Plain read/write IO is generally faster than mmap IO anyway.
You don't use mmap for speed but rather for convenience.

> However, I shall really consider and profile the mprotect/sighandler 
> approach...
> 
> Regards,
> 
> Lutz Vieweg
> 
> PS: I'm using my own allocator already, so using the C-library 
> implementation
>     wouldn't gain me much...

This wasn't why I suggested it. It's has the commit semantics
on memory mapped files that you were asking about (the allocator
is optional I believe).

~mc
