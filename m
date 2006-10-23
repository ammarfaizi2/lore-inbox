Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWJWUCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWJWUCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWJWUCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:02:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:61387 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030192AbWJWUCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:02:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m3r+Y4aREvKvTrb0gZ8UtR7rmSva8414b8ybUbUTb+WBjX56h9MpoUF7DFAeKJwR2y40WdLDJIcPMvfa9Y7uixZjHIz7hp1vw+tji+NBVq0Km87Gvx+JxwxANAJA/wpRCc5ypSd1AqHYYu5C8xYh4hSDECgWX11zGuppxh2J1Zk=
Message-ID: <b637ec0b0610231302q700d0c79m65e73d16e21c06de@mail.gmail.com>
Date: Mon, 23 Oct 2006 22:02:20 +0200
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "kernel list" <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.19-rc2-mm2] oops removing sd card
Cc: drzeus-mmc@drzeus.cx, "Andrew Morton" <akpm@osdl.org>, oakad@yahoo.com
In-Reply-To: <b637ec0b0610220917l5b0720e6l76d349f91038e086@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b637ec0b0610220917l5b0720e6l76d349f91038e086@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More info: I tried to use tifm_core.c and tifm_71xx.c from 2.6.18-mm3
with 2.6.19-rc2-mm2 and the crash also happens.

Hope this helps.
Fabio


On 10/22/06, Fabio Comolli <fabio.comolli@gmail.com> wrote:
> Hi.
> Removing an SD card from my TI FlashMedia controller triggers this:
>
>
> Oct 22 18:07:32 tycho kernel: tifm_7xx1: demand removing card from socket 3
> Oct 22 18:07:33 tycho kernel: PM: Removing info for mmc:mmc0:a95c
> Oct 22 18:07:33 tycho kernel: PM: Removing info for tifm:tifm_sd0:3
> Oct 22 18:07:33 tycho kernel: BUG: unable to handle kernel NULL
> pointer dereference at virtual address 00000030
> Oct 22 18:07:33 tycho kernel:  printing eip:
> Oct 22 18:07:33 tycho kernel: c012cb0d
> Oct 22 18:07:33 tycho kernel: *pde = 00000000
> Oct 22 18:07:33 tycho kernel: Oops: 0000 [#1]
> Oct 22 18:07:33 tycho kernel: SMP
> Oct 22 18:07:33 tycho kernel: last sysfs file:
> /class/net/eth1/statistics/tx_packets
> Oct 22 18:07:33 tycho kernel: Modules linked in: hidp l2cap
> cpufreq_performance bluetooth arc4 ecb blkcipher ieee80211_crypt_wep
> video ac button ipw2200 ieee80211 ieee80211_crypt battery nls_utf8
> ntfs speedstep_centrino cpufreq_conservative cpufreq_stats
> cpufreq_powersave cpufreq_ondemand freq_table snd_intel8x0
> snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss
> snd_seq_midi_event snd_seq pcmcia snd_seq_device snd_pcm_oss
> snd_mixer_oss snd_pcm snd_timer ohci1394 snd 8250_pci ieee1394 8250
> soundcore serial_core snd_page_alloc 8139too ehci_hcd uhci_hcd
> yenta_socket rsrc_nonstatic pcmcia_core tifm_7xx1 mii
> Oct 22 18:07:33 tycho kernel: CPU:    0
> Oct 22 18:07:33 tycho kernel: EIP:
> 0060:[flush_cpu_workqueue+14/129]    Not tainted VLI
> Oct 22 18:07:33 tycho kernel: EFLAGS: 00010282   (2.6.19-rc2-mm2 #2)
> Oct 22 18:07:33 tycho kernel: EIP is at flush_cpu_workqueue+0xe/0x81
> Oct 22 18:07:33 tycho kernel: Process tifm0 (pid: 506, ti=f6246000
> task=f7f94550 task.ti=f62
> Oct 22 18:07:33 tycho kernel: esi: f5111e20   edi: c03808a0   ebp:
> f7f9a8c0   esp: f6247ec8
> Oct 22 18:07:33 tycho kernel: ds: 007b   es: 007b   ss: 0068
> Oct 22 18:07:33 tycho kernel:  [kobject_release+0/8] kobject_release+0x0/0x8
> Oct 22 18:07:33 tycho kernel: Stack: 00000282 f3b44000 00000286
> f7f9a8c0 c012cb89 f3b44000 c03808a0 c012cc29
> Oct 22 18:07:33 tycho kernel:        f3b44000 c0380908 c03808a0
> c02664ae f3b440a4 c025fdad f3b440bc f3b440a4
> Oct 22 18:07:33 tycho kernel:        c0380908 c03808a0 c01df40f
> f3b440bc c01df42f 00000286 f3b44000 c01dff14
> Oct 22 18:07:33 tycho kernel: Call Trace:
> Oct 22 18:07:33 tycho kernel:  [flush_workqueue+9/102] flush_workqueue+0x9/0x66
> Oct 22 18:07:33 tycho kernel:  [destroy_workqueue+10/133]
> destroy_workqueue+0xa/0x85
> Oct 22 18:07:33 tycho kernel:  [tifm_free_device+16/24]
> tifm_free_device+0x10/0x18
> Oct 22 18:07:33 tycho kernel:  [device_release+38/107] device_release+0x26/0x6b
> Oct 22 18:07:33 tycho kernel:  [kobject_cleanup+62/94] kobject_cleanup+0x3e/0x5e
> Oct 22 18:07:33 tycho kernel:  [run_workqueue+127/193] run_workqueue+0x7f/0xc
> Oct 22 18:07:33 tycho kernel:  [kref_put+124/140] kref_put+0x7c/0x8c
> Oct 22 18:07:33 tycho kernel:  [pg0+943689914/1069286400]
> tifm_7xx1_remove_media+0xba/0xfd [tifm_7xx1]
>
>
> After that the system behaves normally but hangs solid during suspend-to-disk.
> This bug didn't happen with 2.6.18-mm3 (last kernel used).
>
> dmesg (with another subsequent bug) and .config attached.
>
> Regards,
> Fabio
>
>
>
