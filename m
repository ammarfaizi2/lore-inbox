Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWIKNpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWIKNpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 09:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWIKNpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 09:45:21 -0400
Received: from h155.mvista.com ([63.81.120.155]:4403 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1750761AbWIKNpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 09:45:19 -0400
Message-ID: <450568F3.3020005@ru.mvista.com>
Date: Mon, 11 Sep 2006 17:47:31 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in libata-dev.git
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org>
In-Reply-To: <450566A2.1090009@garzik.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Jeff Garzik wrote:

>>> The following libata changes are queued for 2.6.19:
>>>
>>> General
>>> -------
>>> * Increase lba28 max sectors from 200 to 256
>>
>>
>> [...]
>>
>>> Jeff Garzik:
>>
>> [...]
>>
>>>       [ATA] Increase lba48 max-sectors from 200 to 256.

>>    So was it for LBA28 or for LBA48?
>>    As for LBA28, it might be quite dangerous. Particularly, I know 
>> that IBM drives used to mistreated 256 as 0 in the past (bumped into 
>> that on a 8-year old drive which is still alive though).

> That's a typo.  The first description ("lba28") is correct.

> Let me know if your IBM drive has problems with current 
> libata-dev.git#upstream...

    It's not likely I'll be able to try it. But I'm absolutely sure that drive 
aborted the read commands with the sector count of 0 (i.e. 256 actually). The 
exact model was IBM DHEA-34331.
    255 sectors actually seems more safe bet.

WBR, Sergei
