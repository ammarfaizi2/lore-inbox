Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVEZCn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVEZCn2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 22:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVEZCn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 22:43:28 -0400
Received: from ppp-6-84.mtl.aei.ca ([206.123.6.84]:28633 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261155AbVEZCnZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 22:43:25 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5-mm1
Date: Wed, 25 May 2005 22:43:20 -0400
User-Agent: KMail/1.7.2
References: <20050525134933.5c22234a.akpm@osdl.org>
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505252243.21092.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 May 2005 16:49, you wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/
> 
> - Added Oracle's clustering filesystem driver, via git-ocfs.
> 
>     OCFS2, a shared disk cluster file system.  See
>     Documentation/filesystems/ocfs2.txt Additionally a users guide is
>     available at:
>     http://oss.oracle.com/projects/ocfs2-tools/dist/documentation/users_guide.txt
> 
> - New Xtensa architecture: Tensilica Xtensa CPU series.
> 
> - Added the Red Hat distributed lock manager for people to look at.
> 
> - Various new git trees.  The remaining holdouts are:

Got the following when I tried to use sound.  Anyone else see problems in alsa land?

May 25 21:17:38 grover kernel: [  131.322558] PGD 2ab13067 PUD 2ab1b067 PMD 2a3f1067 PTE 0
May 25 21:17:38 grover kernel: [  131.351464] CPU 0
May 25 21:17:38 grover kernel: [  131.358041] Modules linked in: radeon nfsd exportfs lockd sunrpc sg parport_pc lp parport ipv6 sd_
mod evdev mousedev tsdev usbhid usb_storage snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore sn
d_page_alloc ehci_hcd ohci_hcd eth1394 sata_nv libata forcedeth
 ohci1394 powernow_k8 freq_table processor cpufreq_userspace w83627hf eeprom i2c_sensor i2c_isa i2c_nforce2 i2c_core sr_mod sbp2 scs
i_mod ieee1394 rtc unix
May 25 21:17:38 grover kernel: [  131.487598] Pid: 5481, comm: artsd Not tainted 2.6.12-rc5-mm1
May 25 21:17:38 grover kernel: [  131.506496] RIP: 0010:[__nosave_end+129759479/2131247104] <ffffffff8813b8f7>{:snd_pcm:snd_pcm_mmap
_data_close+7}
May 25 21:17:38 grover kernel: [  131.535142] RSP: 0018:ffff81002ab9dee0  EFLAGS: 00010286
May 25 21:17:38 grover kernel: [  131.553183] RAX: 00002aaaadb59000 RBX: ffff810029c64988 RCX: fffffffffffffff2
May 25 21:17:38 grover kernel: [  131.576657] RDX: ffff810029c64988 RSI: ffff81002d672ce0 RDI: ffff81002b339f50
May 25 21:17:38 grover kernel: [  131.600129] RBP: ffff81002b3051c0 R08: ffff810029c649a8 R09: ffff81002ab9dec8
May 25 21:17:38 grover kernel: [  131.623602] R10: 0000000000000002 R11: 0000000000000206 R12: ffff81002b339f50
May 25 21:17:38 grover kernel: [  131.647075] R13: ffff81002b339f50 R14: ffff81002e7f2a08 R15: 00002aaaadb67000
May 25 21:17:38 grover kernel: [  131.670548] FS:  00002aaaad6d8f50(0000) GS:ffffffff80550840(0000) knlGS:0000000000000000
May 25 21:17:38 grover kernel: [  131.697165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
May 25 21:17:38 grover kernel: [  131.716064] CR2: 00002aaaadb59098 CR3: 000000002aafd000 CR4: 00000000000006e0
May 25 21:17:38 grover kernel: [  131.739537] Process artsd (pid: 5481, threadinfo ffff81002ab9c000, task ffff81002ada97f0)
May 25 21:17:38 grover kernel: [  131.766439] Stack: ffffffff8016942d 0000000000000000 0000000000000000 ffff81002e7f2a00
May 25 21:17:38 grover kernel: [  131.792174]        ffffffff8016a936 ffff81002d672df0 ffff81002d672e08 ffff81002d672df0
May 25 21:17:38 grover kernel: [  131.818481]        ffff81002e7f2a00 0000000000560600
May 25 21:17:38 grover kernel: [  131.835065] Call Trace:<ffffffff8016942d>{remove_vm_struct+125} <ffffffff8016a936>{do_munmap+550}
May 25 21:17:38 grover kernel: [  131.864282]        <ffffffff8016b0fd>{sys_munmap+77} <ffffffff8010ead6>{system_call+126}
May 25 21:17:38 grover kernel: [  131.890928]
May 25 21:17:38 grover kernel: [  131.898387]
May 25 21:17:38 grover kernel: [  131.898388] Code: 48 8b 80 98 00 00 00 ff 88 08 01 00 00 c3 66 66 66 90 66 66

Hope this helps,
Ed Tomlinson
