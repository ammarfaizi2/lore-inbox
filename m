Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbTBHKb1>; Sat, 8 Feb 2003 05:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbTBHKb1>; Sat, 8 Feb 2003 05:31:27 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:49329 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266981AbTBHKb0>;
	Sat, 8 Feb 2003 05:31:26 -0500
Message-ID: <3E44DEB3.30009@colorfullife.com>
Date: Sat, 08 Feb 2003 11:40:51 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun wrote:

>cpu B:
>        get the ipi and (WITHOUT CHECKING cpu_vm_mask again)
>        go ahead doing tlb flushing.
>
>I am not sure if any disastrous result will happen, but apparently
>an unintended flush has happened.
>
Yes, that's possible. It should be rare (the windows is a few 
instructions long), and on i386 it doesn't hurt.

>In MIPS such a hole could
>cause two processes using the same TLB entries which yields all kinds
>of interesting crashes.
>
What is your problem? Do your mips cpus have mmu contexts (the ability 
to store tlb entries from multiple processes), and you load tlb entries 
with the wrong context id?
The i386 implementation knows that i386 cpus don't support mmu contexts, 
i.e. the whole tlb is flushed during process switches.

--
    Manfred


