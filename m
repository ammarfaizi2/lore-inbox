Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268655AbUHYU2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268655AbUHYU2C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268592AbUHYUZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:25:05 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:65297 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268598AbUHYUWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:22:39 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: TazForEver@dlfp.org, Benoit Dejean <benoit.dejean@placenet.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.8.1] Oops in unix_stream_sendmsg
Date: Wed, 25 Aug 2004 23:22:25 +0300
User-Agent: KMail/1.5.4
References: <1093456804.8399.15.camel@athlon>
In-Reply-To: <1093456804.8399.15.camel@athlon>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408252322.25328.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 August 2004 21:00, Benoit Dejean wrote:
> Last night i got this oops while running XFree4.3
>
> I'm sorry, my kernel is tainted (nvidia latest driver), by the way,
> here's the log. Thank you.
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
>  printing eip:
> c024eb83
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in: ipt_ttl ipt_TCPMSS ip_nat_irc ip_nat_ftp ipt_limit
> ipt_state iptable_mangle ipt_LOG ipt_MASQUERADE ipt_TOS ipt_REDIRECT
> iptable_nat ipt_REJECT ip_conntrack_irc ip_conntrack_ftp ip_conntrack
> iptable_filter ip_tables binfmt_misc md5 ipv6 snd_via82xx
> snd_mpu401_uart snd_emu10k1 snd_rawmidi snd_pcm_oss snd_mixer_oss
> snd_pcm snd_timer snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep
> snd nvidia w83781d i2c_sensor i2c_isa i2c_viapro i2c_core emu10k1
> soundcore ac97_codec usblp uhci_hcd ehci_hcd sd_mod usb_storage usbcore
> scsi_mod rtc
> CPU:    0
> EIP:    0060:[<c024eb83>]    Tainted: P
> EFLAGS: 00013246   (2.6.8.1)
> EIP is at unix_stream_sendmsg+0x203/0x380
> eax: 00000000   ebx: f54e6760   ecx: 00000000   edx: 00000000
> esi: 00000040   edi: c19c2560   ebp: f62ecce0   esp: f7469dd4
> ds: 007b   es: 007b   ss: 0068
> Process XFree86 (pid: 1126, threadinfo=f7469000 task=f7b11750)
> Stack: f7469de8 00000000 f62ecb60 f7469e24 f7469ed8 00000000 00000466
> 00000000
>        00000000 00000000 00000000 00000000 c028dc24 0000000f c029e340
> f7469ed8
>        f7469e74 f76d78c4 c01fca5c 00000040 c4256760 c02be800 c028dc24
> 00000040
> Call Trace:
>  [<c01fca5c>] sock_sendmsg+0x9c/0xd0
>  [<c012fca7>] buffered_rmqueue+0xe7/0x1a0
>  [<c0130021>] __alloc_pages+0x2c1/0x300
>  [<c0104646>] apic_timer_interrupt+0x1a/0x20
>  [<c013a10b>] do_anonymous_page+0xfb/0x160
>  [<c013a1cf>] do_no_page+0x5f/0x300
>  [<c01fceac>] sock_readv_writev+0x6c/0xa0
>  [<c01fcf55>] sock_writev+0x35/0x40
>  [<c01fcf20>] sock_writev+0x0/0x40
>  [<c01468f3>] do_readv_writev+0x1d3/0x220
>  [<c010a985>] convert_fxsr_from_user+0x15/0xe0
>  [<c010ad5b>] restore_i387+0x8b/0x90
>  [<c01469d9>] vfs_writev+0x49/0x60
>  [<c0146ab7>] sys_writev+0x47/0x80
>  [<c0103cb7>] syscall_call+0x7/0xb
> Code: bf 00 f0 ff ff 21 e7 ff 47 14 8b 45 74 a8 01 75 7d f6 45 1d

Please try to reproduce this without nvidia
	or
Mail Nvidia and ask them for help
	or
Mail Nvidia and ask them to give us their source under GPL.

Thank you.
--
vda

