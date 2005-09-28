Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVI2AAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVI2AAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVI2AAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:00:36 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:32774 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1751256AbVI2AAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:00:35 -0400
Message-ID: <433B2E62.5050201@tuxrocks.com>
Date: Wed, 28 Sep 2005 17:59:30 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com,
       hch@infradead.org, oleg@tv-sign.ru, zippel@linux-m68k.org,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
In-Reply-To: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

tglx@linutronix.de wrote:
> This is an updated version which contains following changes:
<snip>
> Thanks for review and feedback.
> 
> tglx

I get this kernel panic on boot (serial capture) with the latest
git tree (2.6.14-rc2++) plus this version of ktimers:

[4294709.646000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[4294709.646000]  printing eip:
[4294709.646000] c0137578
[4294709.646000] *pde = 00000000
[4294709.646000] Oops: 0000 [#1]
[4294709.646000] PREEMPT 
[4294709.646000] Modules linked in: ipw2200 ieee80211 ieee80211_crypt
[4294709.646000] CPU:    0
[4294709.646000] EIP:    0060:[<c0137578>]    Not tainted VLI
[4294709.646000] EFLAGS: 00010087   (2.6.14-rc2-fs2) 
[4294709.646000] EIP is at enqueue_ktimer+0x168/0x280
[4294709.646000] eax: 00000000   ebx: c051c1b4   ecx: 0000002a   edx: 14712508
[4294709.646000] esi: 00000000   edi: f7f42240   ebp: c051c1b8   esp: c05e4f58
[4294709.646000] ds: 007b   es: 007b   ss: 0068
[4294709.646000] Process swapper (pid: 0, threadinfo=c05e4000 task=c0515bc0)
[4294709.646000] Stack: c051c1b4 00000000 c051c1ac 147a7f90 0000002a 147a7f90 0000002a f7f42240 
[4294709.646000]        147a6ff0 0000002a c051c1ac c0137d72 00000005 c05e4000 c051c1b8 c051c1b4 
[4294709.646000]        c05e4000 c0124380 f7f69a90 147a6ff0 0000002a 00000001 c06136c8 0000000a 
[4<0>Kernel panic - not syncing: Fatal exception in interrupt
[4294709.680000]  



Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDOy5haI0dwg4A47wRAnXcAJ996Yrw2nkjuNThfLCep2GRZ0VjzgCcDIWl
IvIgmrrHG3qB8LNszTPITX8=
=TLMU
-----END PGP SIGNATURE-----
