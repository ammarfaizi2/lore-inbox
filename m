Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUIYMnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUIYMnr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 08:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269319AbUIYMnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 08:43:47 -0400
Received: from holomorphy.com ([207.189.100.168]:13544 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266386AbUIYMnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 08:43:45 -0400
Date: Sat, 25 Sep 2004 05:43:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3
Message-ID: <20040925124334.GL9106@holomorphy.com>
References: <20040924014643.484470b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924014643.484470b1.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 01:46:43AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm3/
> - This is a quick not-very-well-tested release - it can't be worse than
>   2.6.9-rc2-mm2, which had a few networking problems.
> - Added Dmitry Torokhov's input system tree to the -mm bk tree lineup.

I hope this isn't terribly redundant, but I've tripped over a bogon in
2.6.9-rc2-mm3 similar to the one I reported for 2.6.9-rc2-mm1. The box
was actually idle at the time.


-- wli

# ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at cfq_iosched:1395
invalid operand: 0000 [1] SMP
CPU 0
Modules linked in: st sr_mod floppy usbserial parport_pc lp parport thermal snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_ioctl32 processor fan button battery snd_intel8x0 snd_ac97_codec snd_pcm ac snd_timer ipv6 snd soundcore snd_page_alloc af_packet joydev usbhid e1000 ehci_hcd i2c_i801 i2c_core uhci_hcd usbcore hw_random evdev dm_mod ext3 jbd aic79xx ata_piix libata sd_mod scsi_mod
Pid: 0, comm: swapper Tainted: MG   2.6.9-rc2-mm3
RIP: 0010:[<ffffffff80293e5b>] <ffffffff80293e5b>{cfq_put_request+139}
RSP: 0018:ffffffff804ce5c8  EFLAGS: 00010046
RAX: 0000000000000000 RBX: 000001017e251b80 RCX: 000001017dc7f0c0
RDX: 0000000000000001 RSI: 000001017e9a7888 RDI: 000001017dc164a8
RBP: 000001010d0e4bd8 R08: 0000000000390625 R09: 0000000000800110
R10: 0000000000000001 R11: 00000000ffffffff R12: 000001017ff67d68
R13: 000001017e9a7888 R14: 000001017ffe0580 R15: 0000000000000200
FS:  0000000000000000(0000) GS:ffffffff80552e80(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000002a95d17808 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff80556000, task ffffffff80421c00)
Stack: 000001017e9a7888 000001017e251b80 0000000000000001 0000000000000001
       000001017e251b80 ffffffff8028855f 000001012f22d180 ffffffff8028aedb
       000001017e9a7888 000001007fe76a00
Call Trace:<IRQ> <ffffffff8028855f>{elv_put_request+15} <ffffffff8028aedb>{__blk_put_request+139}
       <ffffffff8028b013>{end_that_request_last+243} <ffffffffa0006178>{:scsi_mod:scsi_end_request+200}
       <ffffffffa00063f0>{:scsi_mod:scsi_io_completion+576}
       <ffffffffa0000506>{:scsi_mod:scsi_finish_command+214}
       <ffffffffa0000e4a>{:scsi_mod:scsi_softirq+234} <ffffffff8013fd61>{__do_softirq+113}
       <ffffffff8013fe15>{do_softirq+53} <ffffffff80113f1f>{do_IRQ+335}
       <ffffffff80110d27>{ret_from_intr+0}  <EOI> <ffffffff8010f5a6>{mwait_idle+86}
       <ffffffff8010f9fd>{cpu_idle+29} <ffffffff8055971a>{start_kernel+490}
       <ffffffff805591e0>{_sinittext+480}

Code: 0f 0b 88 d3 38 80 ff ff ff ff 73 05 ff c8 48 89 ef 41 89 44
RIP <ffffffff80293e5b>{cfq_put_request+139} RSP <ffffffff804ce5c8>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
