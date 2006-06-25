Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWFYLT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWFYLT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWFYLT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:19:26 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:18202 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932366AbWFYLT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:19:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dTVUi63FODnqaitroGXirLhqEl4KnBkn5kfXZ+Fn46WMiku6Y7c77iBclPG7XzvbU+jFTh135lO39jXEVpygZ//xBu74IgouG3kUtF6ltYiFUkwh0bNe+UOuV1RGShUk1yqkdpvhKvxR0oCl+OIHxlaefvSEfetsEsFXj/m3I6c=
Message-ID: <6bffcb0e0606250419p5e1fca1en5975f3d7a3c12ecd@mail.gmail.com>
Date: Sun, 25 Jun 2006 13:19:25 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060624061914.202fbfb5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/06/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/
>

I found this in /var/log/messages.1

Jun 24 22:29:52 ltg01-fedora kernel: BUG: unable to handle kernel
paging request at virtual address 6b6b6b7b
Jun 24 22:29:52 ltg01-fedora kernel:  printing eip:
Jun 24 22:29:52 ltg01-fedora kernel: c01174f2
Jun 24 22:29:52 ltg01-fedora kernel: *pde = 00000000
Jun 24 22:29:52 ltg01-fedora kernel: Oops: 0000 [#1]
Jun 24 22:29:52 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
Jun 24 22:29:52 ltg01-fedora kernel: last sysfs file:
/devices/platform/i2c-9191/9191-0290/temp2_input
Jun 24 22:29:52 ltg01-fedora kernel: Modules linked in: ipv6 w83627hf
hwmon_vid hwmon i2c_isa af_packet ip_conntrack_netbios
_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp
iptable_filter ip_tables x_tables p4_clockmod speedstep_lib binfmt_
misc thermal processor fan container parport_pc parport nvram
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq
_oss snd_seq_midi_event evdev snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd soundcore ide_cd snd_pa
ge_alloc intel_agp i2c_i801 sk98lin skge agpgart cdrom rtc unix
Jun 24 22:29:52 ltg01-fedora kernel: CPU:    0
Jun 24 22:29:52 ltg01-fedora kernel: EIP:    0060:[<c01174f2>]    Not
tainted VLI
Jun 24 22:29:52 ltg01-fedora kernel: EFLAGS: 00010096   (2.6.17-mm2 #51)
Jun 24 22:29:52 ltg01-fedora kernel: EIP is at task_rq_lock+0x1d/0x57
Jun 24 22:29:52 ltg01-fedora kernel: eax: 6b6b6b6b   ebx: c03cc740
ecx: c031e9e8   edx: f3aac7f0
Jun 24 22:29:52 ltg01-fedora kernel: esi: f3aac7f0   edi: ea28af5c
ebp: ea28af4c   esp: ea28af3c
Jun 24 22:29:52 ltg01-fedora kernel: ds: 007b   es: 007b   ss: 0068
Jun 24 22:29:52 ltg01-fedora kernel: Process sh (pid: 23201,
ti=ea28a000 task=f71f2e30 task.ti=ea28a000)
Jun 24 22:29:52 ltg01-fedora kernel: Stack: f3aac7f0 ea28af84 f3aac7f0
00000010 ea28af6c c011b1a6 f71f2e30 ea28af6c
Jun 24 22:29:52 ltg01-fedora kernel:        00000296 ea28af84 f71f2e30
00000010 ea28af98 c0120d9f 00000000 00000001
Jun 24 22:29:52 ltg01-fedora kernel:        f3726170 f71f2efc ea28af84
ea28af84 ea8f329c 00000000 49dd0140 ea28afac
Jun 24 22:29:52 ltg01-fedora kernel: Call Trace:
Jun 24 22:29:52 ltg01-fedora kernel:  [<c0103d84>] show_stack_log_lvl+0x8c/0x97
Jun 24 22:29:52 ltg01-fedora kernel:  [<c0103ef7>] show_registers+0x12c/0x199
Jun 24 22:29:52 ltg01-fedora kernel:  [<c01040f3>] die+0x18f/0x2ac
Jun 24 22:29:52 ltg01-fedora kernel:  [<c0115afe>] do_page_fault+0x3dd/0x4c3
Jun 24 22:29:52 ltg01-fedora kernel:  [<c0103911>] error_code+0x39/0x40
Jun 24 22:29:52 ltg01-fedora kernel:  [<c011b1a6>] sched_exit+0x29/0xab
Jun 24 22:29:52 ltg01-fedora kernel:  [<c0120d9f>] do_exit+0x7d3/0x801
Jun 24 22:29:52 ltg01-fedora kernel:  [<c0120e46>] sys_exit_group+0x0/0x11
Jun 24 22:29:52 ltg01-fedora kernel:  [<c0120e55>] sys_exit_group+0xf/0x11
Jun 24 22:29:52 ltg01-fedora kernel:  [<c0102ddd>] sysenter_past_esp+0x56/0x79
Jun 24 22:29:52 ltg01-fedora kernel: Code: e9 1a 00 89 d8 e8 c1 e9 1a
00 5b 5e 5d c3 55 89 e5 57 56 53 83 ec 04 89 45 f0 89
d7 9c 8f 07 fa bb 40 c7 3c c0 8b 55 f0 8b 42 04 <8b> 40 10 89 de 03 34
85 00 66 39 c0 89 f0 e8 8d e9 1a 00 8b 55
Jun 24 22:29:52 ltg01-fedora kernel: EIP: [<c01174f2>]
task_rq_lock+0x1d/0x57 SS:ESP 0068:ea28af3c
Jun 24 22:29:52 ltg01-fedora kernel:  <1>Fixing recursive fault but
reboot is needed!

Here is a config file
http://www.stardust.webpages.pl/files/mm/2.6.17-mm2/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
