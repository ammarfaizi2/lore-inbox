Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUJJBPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUJJBPt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 21:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUJJBPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 21:15:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11962 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268019AbUJJBPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 21:15:44 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. Com" <amakarov@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>
In-Reply-To: <41677E4D.1030403@mvista.com>
References: <41677E4D.1030403@mvista.com>
Content-Type: text/plain
Message-Id: <1097370942.1367.12.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 21:15:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 01:59, Sven-Thorsten Dietrich wrote:
> Announcing the availability of prototype real-time (RT)
> enhancements to the Linux 2.6 kernel.
> 

More "scheduling while atomic":

Oct  9 21:06:55 krustophenia kernel: bad: scheduling while atomic!
Oct  9 21:06:55 krustophenia kernel:  [schedule+1578/1584] schedule+0x62a/0x630
Oct  9 21:06:55 krustophenia kernel:  [__p_mutex_down+493/864] __p_mutex_down+0x1ed/0x360
Oct  9 21:06:55 krustophenia kernel:  [kmutex_is_locked+32/64] kmutex_is_locked+0x20/0x40
Oct  9 21:06:55 krustophenia kernel:  [pg0+509195408/1070195712] snd_emu10k1_ptr_read+0xc0/0xe0 [snd_emu10k1]
Oct  9 21:06:55 krustophenia kernel:  [pg0+509190243/1070195712] snd_emu10k1_capture_pointer+0x33/0x70 [snd_emu10k1]
Oct  9 21:06:55 krustophenia kernel:  [pg0+508937310/1070195712] snd_pcm_period_elapsed+0xde/0x3d0 [snd_pcm]
Oct  9 21:06:55 krustophenia kernel:  [pg0+509178406/1070195712] snd_emu10k1_interrupt+0xd6/0x400 [snd_emu10k1]
Oct  9 21:06:55 krustophenia kernel:  [generic_handle_IRQ_event+49/96] generic_handle_IRQ_event+0x31/0x60
Oct  9 21:06:55 krustophenia kernel:  [do_IRQ+317/848] do_IRQ+0x13d/0x350
Oct  9 21:06:55 krustophenia kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Oct  9 21:06:55 krustophenia kernel:  [pg0+509195625/1070195712] snd_emu10k1_ptr_write+0xb9/0xc0 [snd_emu10k1]
Oct  9 21:06:55 krustophenia kernel:  [pg0+509174891/1070195712] snd_emu10k1_voice_init+0x11b/0x1e0 [snd_emu10k1]
Oct  9 21:06:55 krustophenia kernel:  [pg0+509182616/1070195712] snd_emu10k1_voice_free+0x38/0x70 [snd_emu10k1]
Oct  9 21:06:55 krustophenia kernel:  [pg0+509187993/1070195712] snd_emu10k1_playback_hw_free+0x99/0xd0 [snd_emu10k1]
Oct  9 21:06:55 krustophenia kernel:  [pg0+510049279/1070195712] snd_pcm_oss_release_file+0xbf/0x110 [snd_pcm_oss]
Oct  9 21:06:55 krustophenia kernel:  [pg0+510051019/1070195712] snd_pcm_oss_release+0x4b/0x100 [snd_pcm_oss]
Oct  9 21:06:55 krustophenia kernel:  [__fput+292/320] __fput+0x124/0x140
Oct  9 21:06:55 krustophenia kernel:  [filp_close+67/112] filp_close+0x43/0x70
Oct  9 21:06:55 krustophenia kernel:  [sys_close+88/112] sys_close+0x58/0x70
Oct  9 21:06:55 krustophenia kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  9 21:06:56 krustophenia kernel: Mtx: ddfc1ed0 [1445] pri (0) inherit from [1495] pri(10)
Oct  9 21:06:56 krustophenia kernel: bad: scheduling while atomic!
Oct  9 21:06:56 krustophenia kernel:  [schedule+1578/1584] schedule+0x62a/0x630
Oct  9 21:06:56 krustophenia kernel:  [__p_mutex_down+493/864] __p_mutex_down+0x1ed/0x360
Oct  9 21:06:56 krustophenia kernel:  [kmutex_is_locked+32/64] kmutex_is_locked+0x20/0x40
Oct  9 21:06:56 krustophenia kernel:  [pg0+508918664/1070195712] snd_pcm_capture_poll+0x48/0x120 [snd_pcm]
Oct  9 21:06:56 krustophenia kernel:  [do_pollfd+125/144] do_pollfd+0x7d/0x90
Oct  9 21:06:56 krustophenia kernel:  [do_poll+95/192] do_poll+0x5f/0xc0
Oct  9 21:06:56 krustophenia kernel:  [sys_poll+330/560] sys_poll+0x14a/0x230
Oct  9 21:06:56 krustophenia kernel:  [__pollwait+0/160] __pollwait+0x0/0xa0
Oct  9 21:06:56 krustophenia kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  9 21:09:27 krustophenia kernel: Mtx: cde58020 [1383] pri (0) inherit from [3] pri(92)
Oct  9 21:09:27 krustophenia kernel: bad: scheduling while atomic!
Oct  9 21:09:27 krustophenia kernel:  [schedule+1578/1584] schedule+0x62a/0x630
Oct  9 21:09:27 krustophenia kernel:  [__p_mutex_down+493/864] __p_mutex_down+0x1ed/0x360
Oct  9 21:09:27 krustophenia kernel:  [kmutex_is_locked+32/64] kmutex_is_locked+0x20/0x40
Oct  9 21:09:27 krustophenia kernel:  [tcp_v4_rcv+1207/2048] tcp_v4_rcv+0x4b7/0x800
Oct  9 21:09:27 krustophenia kernel:  [ip_local_deliver+154/304] ip_local_deliver+0x9a/0x130
Oct  9 21:09:27 krustophenia kernel:  [ip_rcv+729/992] ip_rcv+0x2d9/0x3e0
Oct  9 21:09:27 krustophenia kernel:  [netif_receive_skb+264/448] netif_receive_skb+0x108/0x1c0
Oct  9 21:09:27 krustophenia kernel:  [process_backlog+125/272] process_backlog+0x7d/0x110
Oct  9 21:09:27 krustophenia kernel:  [ksoftirqd_high_prio+0/192] ksoftirqd_high_prio+0x0/0xc0
Oct  9 21:09:27 krustophenia kernel:  [net_rx_action+108/256] net_rx_action+0x6c/0x100
Oct  9 21:09:27 krustophenia kernel:  [__do_softirq+99/112] __do_softirq+0x63/0x70
Oct  9 21:09:27 krustophenia kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Oct  9 21:09:27 krustophenia kernel:  [ksoftirqd_high_prio+133/192] ksoftirqd_high_prio+0x85/0xc0
Oct  9 21:09:27 krustophenia kernel:  [kthread+163/176] kthread+0xa3/0xb0
Oct  9 21:09:27 krustophenia kernel:  [kthread+0/176] kthread+0x0/0xb0
Oct  9 21:09:27 krustophenia kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  9 21:09:42 krustophenia kernel: Mtx: cbafd9a0 [1388] pri (0) inherit from [3] pri(92)
Oct  9 21:09:42 krustophenia kernel: bad: scheduling while atomic!
Oct  9 21:09:42 krustophenia kernel:  [schedule+1578/1584] schedule+0x62a/0x630
Oct  9 21:09:42 krustophenia kernel:  [__p_mutex_down+493/864] __p_mutex_down+0x1ed/0x360
Oct  9 21:09:42 krustophenia kernel:  [kmutex_is_locked+32/64] kmutex_is_locked+0x20/0x40
Oct  9 21:09:42 krustophenia kernel:  [tcp_v4_rcv+1207/2048] tcp_v4_rcv+0x4b7/0x800
Oct  9 21:09:42 krustophenia kernel:  [ip_local_deliver+154/304] ip_local_deliver+0x9a/0x130
Oct  9 21:09:42 krustophenia kernel:  [ip_rcv+729/992] ip_rcv+0x2d9/0x3e0
Oct  9 21:09:42 krustophenia kernel:  [netif_receive_skb+264/448] netif_receive_skb+0x108/0x1c0
Oct  9 21:09:42 krustophenia kernel:  [process_backlog+125/272] process_backlog+0x7d/0x110
Oct  9 21:09:42 krustophenia kernel:  [ksoftirqd_high_prio+0/192] ksoftirqd_high_prio+0x0/0xc0
Oct  9 21:09:42 krustophenia kernel:  [net_rx_action+108/256] net_rx_action+0x6c/0x100
Oct  9 21:09:42 krustophenia kernel:  [__do_softirq+99/112] __do_softirq+0x63/0x70
Oct  9 21:09:42 krustophenia kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Oct  9 21:09:42 krustophenia kernel:  [ksoftirqd_high_prio+133/192] ksoftirqd_high_prio+0x85/0xc0
Oct  9 21:09:42 krustophenia kernel:  [kthread+163/176] kthread+0xa3/0xb0
Oct  9 21:09:42 krustophenia kernel:  [kthread+0/176] kthread+0x0/0xb0
Oct  9 21:09:42 krustophenia kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  9 21:09:42 krustophenia kernel: Mtx cbafd9a0 task [1388] pri (92) restored pri(0). Next owner [3] pri (92)

Looks like the Mtx debug messages are related.

Lee


