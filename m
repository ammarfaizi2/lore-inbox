Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbTJAXWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTJAXWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:22:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:40608 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262635AbTJAXWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:22:17 -0400
Date: Wed, 1 Oct 2003 16:21:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Konstantin Kletschke <konsti@ludenkalle.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Date/UnixTime of SysRq state dump
Message-Id: <20031001162141.278442d7.akpm@osdl.org>
In-Reply-To: <20031001182859.GA4081%konsti@ludenkalle.de>
References: <20031001182859.GA4081%konsti@ludenkalle.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Kletschke <konsti@ludenkalle.de> wrote:
>
> I know my machine as a rockstable P4 Computer, since
> linux-2.6.0-test5-mm4 it freezes once a day.
> ...
> 
> I have the state dump, catched via serial line at
> http://ludenkalle.de/capture-2003-09-30-linux-2.6.0-test5-mm4.log

Well it is stuck here:

mpd           R current  17897  17786 17898               (NOTLB)
c010de4a 00000000 c0375000 00000001 00000001 00000000 c011de24 eaea56a0 
       00000040 00000000 c011de24 eaea56a0 c02eebbb cdd7be20 00000000 00000040 
       00000010 4037c480 4037c440 eaea56a0 eaea56a0 00000000 cdd7007b 0000007b 
Call Trace:
 [<c010de4a>] do_IRQ+0x24a/0x393
 [<c011de24>] do_page_fault+0x0/0x4fc
 [<c011de24>] do_page_fault+0x0/0x4fc
 [<c02eebbb>] error_code+0x2f/0x38
 [<c01f28fc>] __copy_from_user_ll+0x44/0x6c
 [<f09debdf>] snd_pcm_lib_write_transfer+0x93/0x117 [snd_pcm]
 [<f09df1c1>] snd_pcm_lib_write1+0x55e/0xa42 [snd_pcm]
 [<c025a281>] freed_request+0xa1/0xa9
 [<c0120cac>] default_wake_function+0x0/0x2e
 [<f09df757>] snd_pcm_lib_write+0xb2/0x173 [snd_pcm]
 [<f09deb4c>] snd_pcm_lib_write_transfer+0x0/0x117 [snd_pcm]
 [<f09d8b4a>] snd_pcm_playback_ioctl1+0x585/0x674 [snd_pcm]
 [<c01321e2>] do_timer+0xdf/0xe4
 [<c02eeb1e>] apic_timer_interrupt+0x1a/0x20
 [<f09d90e8>] snd_pcm_playback_ioctl+0x0/0x8d [snd_pcm]
 [<c018dce2>] sys_ioctl+0x214/0x406
 [<c02ee18f>] syscall_call+0x7/0xb

it might be coincidence, it might not be.  Please gather another sysrq
trace next time it happens, just like that one.

