Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSDFSFD>; Sat, 6 Apr 2002 13:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312687AbSDFSFC>; Sat, 6 Apr 2002 13:05:02 -0500
Received: from gw.wmich.edu ([141.218.1.100]:13244 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S312681AbSDFSFB>;
	Sat, 6 Apr 2002 13:05:01 -0500
Subject: Re: Linux 2.4.19pre5-ac3 swsusp panic
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
        swsusp@lister.fornax.hu
In-Reply-To: <1018114652.7477.2.camel@psuedomode>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 06 Apr 2002 13:04:52 -0500
Message-Id: <1018116297.7477.21.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-06 at 12:37, Ed Sweetman wrote:
> On WOLK 3.2 i use swsusp and it works just fine on my P4 system.  With
> the ac kernel i get a panic whenever i try to suspend.  I tried
> including the couple lines that i patched in WOLK 3.2's swsusp mentioned
> in the swsusp mailing list and still it panics.  Perhaps it's due to the
> Taskfile stuff i compiled with, i'll try it without that stuff next. 
> 
> 
> wish i could take a screenshot of the panic


No, taskfile did nothing.

here's all i can see on my screen when executing a suspend I had to type
it up by hand so, hopefully no mistakes. 

I have the preempt patch and lock break patch included too. Since it had
no problem in WOLK and since it really does bring latency down to the
AA's low latency patches (since AC uses rmap I cant use those patches). 

NULL pointer dereference at virtual address 000000c3
printing eip:
c0140b3b
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c0140b3b>] Not tainted
EFLAGS: 00010293
eax: ffffffff	ebx: cf3c1c00	ecx: 00000000	edx: c1313c90
esi: 00000000	edi: 00001000	ebp: 00000001	esp: cff5de04
ds: 0018	es: 0018	ss: 0018
Process bdflush	(pid: 6, stackpage=cff5d000)
stack:	cf3c1c00 c0140bc6 cf3c1c00 c1313c90 00000000 37363534 62614938 66656463
	6a696867 c1313c90 cf265000 cff5dea4 00001000 c0140dd8 c1313c90 00001000
	00000001 c1313c90 cf265000 c014259c c1313c90 00000303 00001000 0000850f
Call Trace: [<c0140bc6>] [<c0140dd8>] [<c014259c>] [<c0137b73>] [<c011aad6>] [<c0137cd3>] [<c0128a44>] [<c012892c>] [<c0129448>] [<c011ae10>] [<c012969e>] [<c0129bd7>] [<c011f72c>] [<c0142e9a>] [<c0142dc0>] [<c0105000>] [<c0105000>] [<c01071d6>] [<c0142dc0>]
Code: 2b 90 c4 00 00 00 c1 fa 02 69 d2 c5 4e ec c4 c1 e2 0c 03 90
<3> bdflush[6] exited with preempt_count 295



