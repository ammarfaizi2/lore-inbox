Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUIXFap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUIXFap (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUIXFap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:30:45 -0400
Received: from holomorphy.com ([207.189.100.168]:10973 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267749AbUIXFam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:30:42 -0400
Date: Thu, 23 Sep 2004 22:30:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040924053031.GW9106@holomorphy.com>
References: <20040916024020.0c88586d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916024020.0c88586d.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 02:40:20AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/
> - Added lots of Ingo's low-latency patches
> - Lockmeter doesn't compile.  Don't enable CONFIG_LOCKMETER.
> - Several architecture updates

Sorry to bother you again. I appear to get this after a couple days of
uptime:

# ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at cfq_iosched:1395
invalid operand: 0000 [1] SMP
CPU 0
Modules linked in: st sr_mod floppy usbserial parport_pc lp parport snd_seq_oss snd_seq_device snd_seq_midi_event snd_seq thermal snd_pcm_oss snd_mixer_oss snd_ioctl32 processor fan button battery snd_intel8x0 snd_ac97_codec snd_pcm ipv6 snd_timer ac snd soundcore snd_page_alloc af_packet joydev usbhid uhci_hcd e1000 usbcore hw_random evdev dm_mod ext3 jbd aic79xx ata_piix libata sd_mod scsi_mod
Pid: 0, comm: swapper Not tainted 2.6.9-rc2-mm1
RIP: 0010:[<ffffffff802909cb>] <ffffffff802909cb>{cfq_put_request+139}
RSP: 0018:ffffffff804c9848  EFLAGS: 00010046
RAX: 0000000000000000 RBX: 000001017e1d0040 RCX: 000001017e23a0c0
RDX: 0000000000000001 RSI: 0000010132292990 RDI: 000001017e4b2ef8
RBP: 000001017e9e6968 R08: 0000000000000002 R09: 0000000000800110
R10: 0000000000000001 R11: 0000010006466560 R12: 000001017ff68c08
R13: 0000010132292990 R14: 000001017ffdf100 R15: 0000000000000200
FS:  0000000000000000(0000) GS:ffffffff8054d900(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000002a9b7f4000 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff80550000, task ffffffff8041dc80)
Stack: 0000010132292990 000001017e1d0040 0000000000000001 0000000000000001
       000001017e1d0040 ffffffff802850cf 000001015e4bfc80 ffffffff80287a4b
       0000010132292990 0000010037c1c800
Call Trace:<IRQ> <ffffffff802850cf>{elv_put_request+15} <ffffffff80287a4b>{__blk_put_request+139}
       <ffffffff80287b83>{end_that_request_last+243} <ffffffffa0006178>{:scsi_mod:scsi_end_request+200}
       <ffffffffa00063f0>{:scsi_mod:scsi_io_completion+576}
       <ffffffffa0000506>{:scsi_mod:scsi_finish_command+214}
       <ffffffffa0000e4a>{:scsi_mod:scsi_softirq+234} <ffffffff8013da51>{__do_softirq+113}
       <ffffffff8013db05>{do_softirq+53} <ffffffff80113f1f>{do_IRQ+335}
       <ffffffff80110d27>{ret_from_intr+0}  <EOI> <ffffffff8010f5a6>{mwait_idle+86}
       <ffffffff8010f9fd>{cpu_idle+29} <ffffffff8055371a>{start_kernel+490}
       <ffffffff805531e0>{_sinittext+480}

Code: 0f 0b e7 9d 38 80 ff ff ff ff 73 05 ff c8 48 89 ef 41 89 44
RIP <ffffffff802909cb>{cfq_put_request+139} RSP <ffffffff804c9848>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

