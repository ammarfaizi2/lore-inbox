Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVEPMfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVEPMfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVEPMfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:35:34 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:13988 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261573AbVEPMed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:34:33 -0400
Message-ID: <42889354.7030904@ens-lyon.org>
Date: Mon, 16 May 2005 14:34:28 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Soft lockup with -mm
References: <42792BC8.9010005@ens-lyon.org> <20050504132302.2ce4869b.akpm@osdl.org> <427935DF.5010505@ens-lyon.org>
In-Reply-To: <427935DF.5010505@ens-lyon.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin a écrit :
> Andrew Morton a écrit :
> 
>>Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>>
>>>I was seeing a lockup with several -mm releases since 2.6.12-rc2-mm1
>>>(IIRC). With 2.6.12-rc2-mm1, I remember getting the lockup a few minutes
>>>after boot time.
>>>With 2.6.12-rc3-mm1, I waited several days before getting it.
>>>But, I finally caught this one with netconsole. So here it is:
>>>
>>>BUG: soft lockup detected on CPU#0!
>>>Pid: 0, comm:              swapper
>>>EIP: 0060:[<c02d40a5>] CPU: 0
>>>EIP is at _spin_unlock_irqrestore+0x5/0x30
>>>EFLAGS: 00000286    Not tainted  (2.6.12-rc3-mm1=Pignouf)
>>>EAX: c18e8160 EBX: c18e8160 ECX: 00000001 EDX: 00000286
>>>ESI: c18e0160 EDI: dbf96c64 EBP: ffffffff DS: 007b ES: 007b
>>>CR0: 8005003b CR2: b6e43000 CR3: 0e912000 CR4: 00000690
>>>[<c012a635>] __mod_timer+0xc5/0xf0
>>
>>
>>It could be the timer bug.  Can you try it with Oleg's fix?
> 
> 
> Ok, thanks.
> I applied it on top of mm2 and started praying for a few days
> until something happens or not.

Hi Andrew,

This box is running 2.6.12-rc3-mm2 with Oleg's fix for 12 days.
Looks like the soft-lockup I was seeing is fixed.
I'll try to keep this box running -mm kernels to be sure the lockup
won't occur anymore.

Thanks,
Brice
