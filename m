Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270270AbUJUAQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270270AbUJUAQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270505AbUJUAHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:07:52 -0400
Received: from li-22.members.linode.com ([64.5.53.22]:61196 "EHLO
	www.cryptography.com") by vger.kernel.org with ESMTP
	id S269175AbUJUAEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:04:08 -0400
Message-ID: <4176FCB8.3060103@root.org>
Date: Wed, 20 Oct 2004 17:03:04 -0700
From: Nate Lawson <nate@root.org>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS,
 ...)
References: <20041020191531.GC21315@elf.ucw.cz> <1098311478.4989.100.camel@desktop.cunninghams> <20041020225639.GD29863@elf.ucw.cz>
In-Reply-To: <20041020225639.GD29863@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>>>I'm seeing bad problem with N620c notebook (and have reports of more
>>>machines behaving like this, for example ASUS L8400C.) If I shutdown
>>>machine with lid closed, opening lid will power the machine up. Ouch.
>>>2.6.7 behaves okay.
>>
>>:> Some people would love to have the machine power up when they open
>>the lid! Wish my XE3 would do that!

This problem sounds like a wake GPE is enabled for the lid switch and 
that it has a _PRW that indicates it can wake the system from S5.  If 
this is the case, just disabled the GPE.

> :-). Well for some other people it powers up when they unplug AC
> power, and *that* is nasty. I'd like my machine to stay powered down
> when I tell it so.

This is likely a similar GPE problem.  The GPE for the EC fires even in 
S5.  I think the EC GPE should be disabled in the suspend method.

-- 
Nate
