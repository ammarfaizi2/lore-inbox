Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbUKDQaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbUKDQaj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUKDQai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:30:38 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:53922 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S262285AbUKDQaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:30:22 -0500
Message-ID: <418A5937.3070707@rnl.ist.utl.pt>
Date: Thu, 04 Nov 2004 16:30:47 +0000
From: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040922)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Jim Nelson <james4765@verizon.net>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net> <200411031147.14179.gene.heskett@verizon.net> <20041103174459.GA23015@DervishD> <200411031353.39468.gene.heskett@verizon.net> <20041103192648.GA23274@DervishD> <4189586E.2070409@verizon.net>
In-Reply-To: <4189586E.2070409@verizon.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Nelson wrote:
> DervishD wrote:
> 
>>     Hi Gene :)
>>
>>  * Gene Heskett <gene.heskett@verizon.net> dixit:
>>
>>>>   Then the children are reparented to 'init' and 'init' gets rid
>>>> of them. That's the way UNIX behaves.
>>>
>>>
>>> Unforch, I've *never* had it work that way.  Any dead process I've 
>>> ever had while running linux has only been disposable by a reboot.
>>
>>
>>
>>     Well, you know, shit happens... Anyway, could you define 'dead'?
>> Because if you're talking about zombies whose parent dies, they're
>> killable easily: just wait until init reaps them (usually in less
>> than 5 minutes since they dead). If you are talking about zombies who
>> has their parent alive, then it's a bug in the application, not the
>> kernel. In fact I wouldn't like if the kernel reaps my children
>> before I do, just in case I want to do something.
>>
>>     If you're talking about unkillable processes (those stuck in
>> disk-sleep state), you're right: only rebooting can kill them
>> (although sometimes they go out of D state and die normally). Bad
>> luck for you if any dead process you've ever had while running linux
>> has been of this kind :(
>>
> 
> I did this to myself a number of times when I was first learning Samba - 
> even an ls would become unkillable.  You couldn't rmmod smb, since it 
> was in use, and you couldn't kill the process, since it was waiting on a 
> syscall.  Ergh.

the exact same happened to me, but my case was with ntfs. zip processes 
just got stuch in "D" state because of some unhandled names... i 
couldn't kill the processes. i don't think this is an easy thing to do, 
tough it should be possible to kill -9 these processes and make them exit.

is this feasible?

regards,
pedro venda.
-- 

Pedro João Lopes Venda
email: pjvenda@rnl.ist.utl.pt
http://maxwell.rnl.ist.utl.pt

Equipa de Administração de Sistemas
Rede das Novas Licenciaturas (RNL)
Instituto Superior Técnico
http://www.rnl.ist.utl.pt
http://mega.ist.utl.pt
