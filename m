Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUJLPDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUJLPDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUJLPBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:01:42 -0400
Received: from zamok.crans.org ([138.231.136.6]:42112 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S265207AbUJLPAr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:00:47 -0400
To: Fabio =?iso-8859-1?Q?Codec=E0?= <fabiocode@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic with 2.6.9-rc3-mm3 and 2.6.9-rc4-mm1
References: <592474b04101207292d8a6983@mail.gmail.com>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Tue, 12 Oct 2004 17:00:46 +0200
In-Reply-To: <592474b04101207292d8a6983@mail.gmail.com> (Fabio
 =?iso-8859-1?Q?Codec=E0's?=
	message of "Tue, 12 Oct 2004 16:29:22 +0200")
Message-ID: <871xg4j80x.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Codecà <fabiocode@gmail.com> disait dernièrement que :

> Hi to all, I have a problem with the two kernel in the subject...I use
> gentoo and during an emerge operation I get the following message from
> the kernel:
>
> Oct 12 13:50:20 brutus Unable to handle kernel paging request at
> virtual address 0001771c
> Oct 12 13:50:20 brutus printing eip:
> Oct 12 13:50:20 brutus c011c386
> Oct 12 13:50:20 brutus *pde = 00000000
> Oct 12 13:50:20 brutus Oops: 0002 [#1]
> Oct 12 13:50:20 brutus Modules linked in: ohci_hcd 8139too mii
> ohci1394 ieee1394 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd
> snd_page_alloc ehci_hcd uhci_hcd intel_agp agpgart usbcore
> Oct 12 13:50:20 brutus CPU:    0
> Oct 12 13:50:20 brutus EIP:    0060:[<c011c386>]    Not tainted VLI
> Oct 12 13:50:20 brutus EFLAGS: 00010082   (2.6.9-rc4-mm1) 
> Oct 12 13:50:20 brutus EIP is at profile_hit+0x26/0x30
> Oct 12 13:50:20 brutus eax: 0001771c   ebx: ded78a40   ecx: 00000000  
> edx: 00000000
> Oct 12 13:50:20 brutus esi: ffffffea   edi: 00000000   ebp: dd0c7fbc  
> esp: dd0c7f8c
> Oct 12 13:50:20 brutus ds: 007b   es: 007b   ss: 0068
> Oct 12 13:50:20 brutus Process regxpcom (pid: 7796,
> threadinfo=dd0c6000 task=ded78a40)
> Oct 12 13:50:20 brutus Stack: c0118d31 00000002 c0105fef 00000004
> c05247a0 c0118f46 bfffe45c 00000082
> Oct 12 13:50:20 brutus 00000000 00001e74 b7f5ae20 b7f58060 dd0c6000
> c0105fef 00001e74 00000000
> Oct 12 13:50:20 brutus bfffe45c b7f5ae20 b7f58060 bfffe438 0000009c
> 0000007b 0000007b 0000009c
> Oct 12 13:50:20 brutus Call Trace:
> Oct 12 13:50:20 brutus [<c0118d31>] setscheduler+0xb1/0x1e0
> Oct 12 13:50:20 brutus [<c0105fef>] syscall_call+0x7/0xb
> Oct 12 13:50:20 brutus [<c0118f46>] sys_sched_getparam+0x56/0x90
> Oct 12 13:50:20 brutus [<c0105fef>] syscall_call+0x7/0xb
> Oct 12 13:50:20 brutus Code: 04 83 c4 08 c3 8b 44 24 08 8b 0d 2c 9a 52
> c0 8b 15 28 9a 52 c0 2d 28 02 10 c0 d3 e8 4a 39 c2 0f 46 c2 8b 15 24
> 9a 52 c0 8d 04 82 <ff> 00 c3 8d b4 26 00 00 00 00 b8 da ff ff ff c3 8d
> 76 00 8d bc
>
>
> I don't what can do...anyone can help me?
> Thanks to all!

yep
just do:
cd /path/to/kernel/source
wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/optimize-profile-path-slightly.patch
patch -p1 -R -i optimize-profile-path-slightly.patch
the oopsen you see should have gone away.

(this time, no typo 8-))

-- 
<erikm> cleartape: kernels don't do magic, they just implement mechanisms

	- Erik Mouw on #kernelnewbies

