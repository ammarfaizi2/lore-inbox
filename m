Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWD0Qyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWD0Qyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 12:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWD0Qyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 12:54:37 -0400
Received: from smtp-out.google.com ([216.239.45.12]:8515 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030195AbWD0Qyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 12:54:36 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
	b=ty+RLvnzFz87/Rj4tDKF/0Ie0ZL5NIxfR/w4jutuZRIAPWvVTeYk7ucGkSoMeIOND
	kByUEzDl2a2ZLzaYqCmcw==
Message-ID: <4450F732.90704@google.com>
Date: Thu, 27 Apr 2006 09:54:10 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>,
       linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.17-rc2-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, one more time, cause I'm an idiot, and can't type.

--------------------------------

Still crashes in LTP on x86_64:
(introduced in previous release)

http://test.kernel.org/abat/29674/debug/console.log

Different panic on 2-way ppp64  blade, again during LTP.

http://test.kernel.org/abat/29675/debug/console.log

  Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=128 NUMA
Modules linked in: evdev joydev st sr_mod ipv6 usbcore sg dm_mod
NIP: C000000000048F0C LR: C0000000000AF854 CTR: 800000000000A984
REGS: c0000000074af560 TRAP: 0300   Not tainted  (2.6.17-rc2-mm1-autokern1)
MSR: 8000000000001032 <ME,IR,DR>  CR: 24002024  XER: 00000010
DAR: C00001800056B0B0, DSISR: 0000000040010000
TASK = c000000007460800[84] 'kswapd0' THREAD: c0000000074ac000 CPU: 1
GPR00: 8000000000001032 C0000000074AF7E0 C000000000691420 C0000000007586A8
GPR04: 000000000000000F 0000000000000000 0000000000000000 0000000000000000
GPR08: C0000000FE80AAD8 C00001800056B080 0000000000000001 C0000000007586A8
GPR12: 0000000024002024 C00000000056B280 0000000000000020 0000000000000020
GPR16: 0000000000000020 0000000000000000 0000000000000000 000000000000000F
GPR20: C0000000074AF860 0000000000000000 C0000000FFFF3098 0000000000000001
GPR24: C0000000074AFE00 C00000000059FCC0 0000000000000001 C0000000007586A8
GPR28: C000000000545680 0000000000000022 C0000000005A4DA8 C00000000056B080
NIP [C000000000048F0C] .try_to_wake_up+0x98/0x598
LR [C0000000000AF854] .add_to_swapped_list+0x23c/0x264
Call Trace:
[C0000000074AF7E0] [C0000000005A4DA8] 0xc0000000005a4da8 (unreliable)
[C0000000074AF8F0] [C0000000000AF854] .add_to_swapped_list+0x23c/0x264
[C0000000074AF990] [C000000000098290] .remove_mapping+0x88/0x174
[C0000000074AFA20] [C000000000099340] .shrink_zone+0xc74/0xf9c
[C0000000074AFD30] [C00000000009A008] .kswapd+0x3e4/0x54c
[C0000000074AFED0] [C0000000000705C8] .kthread+0x174/0x1c4
[C0000000074AFF90] [C000000000024AB0] .kernel_thread+0x4c/0x68
Instruction dump:
3a810080 7d2000a6 79208042 f9340000 78008000 7c010164 e97b0008 ebfe8008
eb9e8000 812b0010 79294da4 7d29fa14 <e8090030> 7fbc0214 7fa3eb78 4841f615
-- 0:conmux-control -- time-stamp -- Apr/27/06  5:10:48 --

