Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUIOLg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUIOLg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 07:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUIOLg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 07:36:59 -0400
Received: from holomorphy.com ([207.189.100.168]:20635 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265196AbUIOLgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 07:36:53 -0400
Date: Wed, 15 Sep 2004 04:36:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-ID: <20040915113635.GO9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 01:50:03AM -0700, Andrew Morton wrote:
> +cfq-iosched-v2.patch
>  Major revamp of the CFQ IO scheduler

While editing some files while booted into 2.6.9-rc1-mm5:

# ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at cfq_iosched:1359
invalid operand: 0000 [1] SMP
CPU 0
Modules linked in: st sr_mod floppy usbserial parport_pc lp parport snd_seq_oss snd_seq_device snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_ioctl32 thermal processor fan button battery snd_intel8x0 snd_ac97_codec snd_pcm snd_timer ipv6 ac snd soundcore snd_page_alloc af_packet joydev usbhid ehci_hcd e1000 uhci_hcd usbcore hw_random evdev dm_mod ext3 jbd aic79xx ata_piix libata sd_mod scsi_mod
Pid: 9615, comm: cc1 Not tainted 2.6.9-rc1-mm5
RIP: 0010:[<ffffffff80290ab6>] <ffffffff80290ab6>{cfq_put_request+166}
RSP: 0000:ffffffff804c8638  EFLAGS: 00010046
RAX: 0000000000000000 RBX: 000001017e2c3b80 RCX: 00000000000049f2
RDX: 0000000000000001 RSI: 000001017e75cd10 RDI: 000001000b5d57c0
RBP: 000001017e75cd10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 000001016d1b3db0
R13: 000001017d142c08 R14: 000001017fff1400 R15: 0000000000000001
FS:  0000002a9588d6e0(0000) GS:ffffffff8055c880(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000548000 CR3: 0000000000101000 CR4: 00000000000006e0
Process cc1 (pid: 9615, threadinfo 000001011f720000, task 000001012d4897e0)
Stack: 0000000000001000 000001016d1b3db0 000001017e2c3b80 0000000000000001
       0000000000000001 000001017e2c3b80 0000000000000200 ffffffff8028527f
       0000010163320300 ffffffff80287bfb
Call Trace:<IRQ> <ffffffff8028527f>{elv_put_request+15} <ffffffff80287bfb>{__blk_put_request+139}
       <ffffffff80287d33>{end_that_request_last+243} <ffffffffa0006178>{:scsi_mod:scsi_end_request+200}
       <ffffffffa00063f0>{:scsi_mod:scsi_io_completion+576}
       <ffffffffa0000506>{:scsi_mod:scsi_finish_command+214}
       <ffffffffa0000e4a>{:scsi_mod:scsi_softirq+234} <ffffffff8013df61>{__do_softirq+113}
       <ffffffff8013e015>{do_softirq+53} <ffffffff80113f1f>{do_IRQ+335}
       <ffffffff80110c97>{ret_from_intr+0}  <EOI>

Code: 0f 0b 26 9b 38 80 ff ff ff ff 4f 05 ff c8 41 89 44 95 58 0f
RIP <ffffffff80290ab6>{cfq_put_request+166} RSP <ffffffff804c8638>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


-- wli
