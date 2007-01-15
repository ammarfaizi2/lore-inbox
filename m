Return-Path: <linux-kernel-owner+w=401wt.eu-S1751434AbXAOTlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbXAOTlZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbXAOTlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:41:25 -0500
Received: from mail.tmr.com ([64.65.253.246]:45226 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbXAOTlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:41:24 -0500
Message-ID: <45ABD966.7030207@tmr.com>
Date: Mon, 15 Jan 2007 14:43:34 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Initramfs and /sbin/hotplug fun
References: <45AB8CB9.2000209@walrond.org> <20070115170412.GA26414@aepfle.de> <45ABBB8B.6000505@walrond.org>
In-Reply-To: <45ABBB8B.6000505@walrond.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:
> Olaf Hering wrote:
>> On Mon, Jan 15, Andrew Walrond wrote:
>>
>>> To solve this, I deleted /sbin/hotplug from the initramfs archive and 
>>> modified /init to reinstate it once it gets control. This works fine, 
>>> but seems inelegant. Is there a better solution? Should sbin/hotplug 
>>> be called at all before the kernel has passed control to /init?
>>
>> Yes, it should be called.
> 
> Ok
> 
>> /sbin/hotplug and /init are two very different and unrelated things.
> 
> Well, of course. But looking at the thread provided by Jan, it seems the 
> kernel might not be in any fit state to service the (userspace) hotplug 
> infrastructure when it makes the calls (Ie can't create pipes yet).
> 
> The kernel wouldn't call /init (or /sbin/init) before it was fully ready 
> to handle userspace processes, so why should it feel able to call the 
> hotplug userspace?
> 
I could speculate in case it needs to hotplug something to complete 
boot, but it could just be a thinko.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
