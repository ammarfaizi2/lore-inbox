Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVCUXdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVCUXdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVCUWtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:49:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:23758 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262124AbVCUWsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:48:17 -0500
Date: Mon, 21 Mar 2005 14:47:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: andrei@arhont.com
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: amd64 2.6.11 oops on modprobe
Message-Id: <20050321144752.6acf4e75.akpm@osdl.org>
In-Reply-To: <1110024688.5494.2.camel@whale.core.arhont.com>
References: <1110024688.5494.2.camel@whale.core.arhont.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Mikhailovsky <andrei@arhont.com> wrote:
>
> I get the oops during the boot up process. This did not happen in
> 2.6.10/2.6.9.

Andrei, is this still happening in 2.6.12-rc1?

Thanks.

> Here is the output from dmesg:
> 
> Unable to handle kernel paging request at ffffffff880db000 RIP: 
> <ffffffff880d909f>{:saa7110:saa7110_write_block+127}
> PGD 103027 PUD 105027 PMD 3ee64067 PTE 0
> Oops: 0000 [1] 
> CPU 0 
> Modules linked in: adv7175 saa7110 zr36067 videocodec videodev sata_nv
> libata snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
> snd_timer snd snd_page_alloc i2c_nforce2 it87 eeprom i2c_sensor i2c_isa
> sk98lin
> Pid: 2604, comm: modprobe Not tainted 2.6.11-amd64
> RIP: 0010:[<ffffffff880d909f>]
> <ffffffff880d909f>{:saa7110:saa7110_write_block+127}
> RSP: 0018:ffff81003f6c5b78  EFLAGS: 00010287
> RAX: 000000000000139f RBX: 00000000ffffec36 RCX: 000000000000002a
> RDX: 000000000000009f RSI: 0000000000000001 RDI: ffffffff880bf838
> RBP: 000000000000139f R08: 0000000000000000 R09: ffff81003efd63a8
> R10: 0000000000000001 R11: ffffffff802f75d0 R12: ffffffff880db000
> R13: ffff81003f3e0200 R14: ffff81003e0df200 R15: 0000000000000001
> FS:  00002aaaaaac5520(0000) GS:ffffffff80500180(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: ffffffff880db000 CR3: 000000003e125000 CR4: 00000000000006e0
> Process modprobe (pid: 2604, threadinfo ffff81003f6c4000, task
> ffff81003ed59700)
> Stack: 0000000000000076 0000000000000000 0000000000000000
> 0000000000000000 
>        0000000000000000 ffffffffffff0000 ffffffffffffffff
> ffff81003e0df228 
>        ffff002a0001004e ffff81003f6c5b78 
> Call Trace:<ffffffff880d9930>{:saa7110:saa7110_detect_client+0} 
>        <ffffffff880d9ab4>{:saa7110:saa7110_detect_client+388} 
>        <ffffffff802f6812>{i2c_probe+642}
> <ffffffff802f4c24>{i2c_add_adapter+468} 
>        <ffffffff802f7928>{i2c_bit_add_bus+840}
> <ffffffff880d7600>{:zr36067:init_dc10_cards+1536} 
>        <ffffffff801468e1>{sys_init_module+5857}
> <ffffffff80174de7>{do_lookup+55} 
>        <ffffffff8021f440>{prio_tree_insert+48}
> <ffffffff880d7000>{:zr36067:init_dc10_cards+0} 
>        <ffffffff80113fff>{sys_mmap+191} <ffffffff8010e1fa>{system_call
> +126} 
>        
> 
> Code: 41 0f b6 04 24 ff c5 49 ff c4 41 88 44 15 00 88 04 0c 8b 44 
> RIP <ffffffff880d909f>{:saa7110:saa7110_write_block+127} RSP
> <ffff81003f6c5b78>
> CR2: ffffffff880db000
> 
> If anyone need more debugging info, I am ready to help
> 
> 
> -- 
> Andrei Mikhailovsky
> 
