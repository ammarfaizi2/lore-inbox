Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbTCCPDg>; Mon, 3 Mar 2003 10:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbTCCPDg>; Mon, 3 Mar 2003 10:03:36 -0500
Received: from rzserv1.gsi.de ([140.181.96.11]:30602 "EHLO rzserv1.gsi.de")
	by vger.kernel.org with ESMTP id <S265154AbTCCPDd>;
	Mon, 3 Mar 2003 10:03:33 -0500
Message-ID: <3E637137.3010105@GSI.de>
Date: Mon, 03 Mar 2003 16:13:59 +0100
From: ChristopherHuhn <c.huhn@gsi.de>
Organization: GSI
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: de-de, en-us, fr-fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-smp <linux-smp@vger.kernel.org>, support-gsi@credativ.de
Subject: Re: Kernel Bug at spinlock.h ?!
References: <3E630E3D.8060405@GSI.de> <Pine.LNX.4.50.0303030348130.25240-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0303030348130.25240-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

>>Sounds like possible memory corruption (can you vouch for the reliability 
>>of your RAM?) Might be worthwhile posting the oops in it's entirety. Is 
>>EIP normally in __run_timers? Do you run a heavy networking load?
>>
as apparently every machine in our farm is affected, I cannot believe in 
a corrupted memory. I've started to run memtest86 on a machine that just 
oopsed though, but it didn't find any errors (yet).

>Feb 24 14:45:34 lxb006 kernel: ICH3: BIOS setup was incomplete.
>
Does this mean we should upgrade to 2.5?

Kind regards,

Christopher


Here comes a complete oops that just occured:

Unable to handle kernel NULL pointer dereference at virtual address 00000002
priniting eip:
e40e5cfc
*pde: 00000000
Oops: 0002
Cpu: 0
EIP: 0010:[<e40e5cfc>]    Not tainted
EFLAGS: 00010246
eax: 00000002    ebx: e40e5cfc    ecx: c03f9208    edx: 00000000
esi: e40e5cb0    edi: 00000001    ebp: d5d15cd0    esp: d5d15cbc
ds: 0018    es: 0018    ss: 0018
Process adsmcli (pid: 13223, stackpage=d5d15000)
Stack: c02c6783 e40e5cb0 e40e4cb0 c02c66a0 0ac9682a d5d15d08 c012564b 
e40e5cb0
    00000000 00000000 00000000 00000001 00000000 c03f9600 c041c30c c041c30c
    ...
Call Trace: [<c02c6783>] [<c02c66a0>] [<c0125646>] [<c012139a>] [<c0121263>]
    [<c0120fdd>] [<c02a50dc>] [<c02a3c68>] [<c02abc50>] [<c027eec2>] 
[<c029c877>]
    ...

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 2b 68 c9 0a
<0> Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


