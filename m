Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWIZSTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWIZSTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 14:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWIZSTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 14:19:54 -0400
Received: from zod.pns.networktel.net ([209.159.47.6]:65248 "EHLO
	zod.pns.networktel.net") by vger.kernel.org with ESMTP
	id S1751271AbWIZSTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 14:19:54 -0400
Message-ID: <45196CC7.6020000@versaccounting.com>
Date: Tue, 26 Sep 2006 13:09:11 -0500
From: Ben Duncan <ben@versaccounting.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: EIP Errors kernel 2.6.18 .AND hard lockup ...
References: <45194883.3080700@versaccounting.com> <6bffcb0e0609260851q5d97f784i47d43f2076843600@mail.gmail.com>            <451965E5.1080600@versaccounting.com> <200609261800.k8QI0a5i027891@turing-police.cc.vt.edu>
In-Reply-To: <200609261800.k8QI0a5i027891@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I can remove the module so it no longer is loaded ..

It is replicate able, but randomly. Seems to occur when I hammer on
the SATA drive in the system, which is running on a add-on SIL 3112a
controller card.

Anyway, driver is removed, system rebooted, ksyms logged.
I will hammer again on the system to see if it fails ...

Thanks  ...

Valdis.Kletnieks@vt.edu wrote:
> 
> 
>>desktop kernel: EIP:    0060:[<c01ba714>]    Tainted: P      VLI
> 
>                              proprietary module loaded--^
> 
> 
>>To me seems to be a PDFLUSH eip and the nvidia stuff is just
>>a by product of loaded modules, no?
> 
> 
> The point is that we can't know that the NVidia module hasn't stomped on
> some random memory location that happened to corrupt a radix tree.  Note
> that this is true even if you've loaded and then unloaded the module - it
> may have splatted something before it departed....
> 
> Is it a replicatable error, and if so, can you replicate it without loading
> the NVidia module?  If you can come up with a traceback that doesn't have
> an NVidia tainting in it, we'll be glad to look at it.  Conversely, if you're
> able to replicate it with nvidia loaded, but not without, toss it over
> the fence to your friend.

-- 
Ben Duncan   - Business Network Solutions, Inc. 336 Elton Road  Jackson MS, 39212
"Never attribute to malice, that which can be adequately explained by stupidity"
        - Hanlon's Razor

