Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUGMOYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUGMOYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUGMOYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:24:36 -0400
Received: from tristate.vision.ee ([194.204.30.144]:48023 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265224AbUGMOYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:24:32 -0400
Message-ID: <40F3F0A0.9080100@vision.ee>
Date: Tue, 13 Jul 2004 17:24:32 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
Organization: Vision
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040705)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
References: <20040713122805.GZ21066@holomorphy.com>
In-Reply-To: <20040713122805.GZ21066@holomorphy.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My first results with 2.6.8-rc1 + preempt-timing:

Boot-time:

2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at kmap_atomic+0x13/0x70 and ending at kunmap_atomic+0x5/0x20
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at buffered_rmqueue+0xea/0x190 and ending at 
buffered_rmqueue+0x144/0x190
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at search_by_key+0xe3/0xf70 and ending at do_IRQ+0xec/0x130
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at copy_mm+0x2e6/0x3b0 and ending at copy_mm+0x331/0x3b0
11ms non-preemptible critical section violated 1 ms preempt threshold 
starting at ohci_hub_resume+0x3c/0x350 [ohci_hcd] and ending at 
ohci_hub_resume+0x79/0x350 [ohci_hcd]
14ms non-preemptible critical section violated 1 ms preempt threshold 
starting at schedule+0x36/0x480 and ending at schedule+0x291/0x480
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at new_inode+0x1a/0x80 and ending at new_inode+0x58/0x80
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at kmap_atomic+0x13/0x70 and ending at kunmap_atomic+0x5/0x20
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at kmap_atomic+0x13/0x70 and ending at kunmap_atomic+0x5/0x20

Normal use (logging in, browsing, playing video with mplayer, moving 
windows around, etc):

2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at search_by_key+0xe3/0xf70 and ending at 
smp_apic_timer_interrupt+0x9a/0xe0
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at do_munmap+0xd2/0x140 and ending at do_munmap+0xeb/0x140
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at kmap_atomic+0x13/0x70 and ending at kunmap_atomic+0x5/0x20
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at __d_lookup+0x66/0x170 and ending at __d_lookup+0x9c/0x170
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at kmap_atomic+0x13/0x70 and ending at kunmap_atomic+0x5/0x20
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at copy_mm+0x2e6/0x3b0 and ending at copy_mm+0x331/0x3b0
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at find_get_page+0x14/0x60 and ending at find_get_page+0x2f/0x60
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at dev_queue_xmit+0x7f/0x320 and ending at 
dev_queue_xmit+0x27f/0x320
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at dev_queue_xmit+0x7f/0x320 and ending at 
dev_queue_xmit+0x27f/0x320
49ms non-preemptible critical section violated 1 ms preempt threshold 
starting at snd_pcm_action_lock_irq+0x1b/0x1d0 [snd_pcm] and ending at 
snd_pcm_action_lock_irq+0x65/0x1d0 [snd_pcm]
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at do_no_page+0xd5/0x310 and ending at do_no_page+0x178/0x310
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at fget+0x28/0x70 and ending at fget+0x41/0x70
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at sys_ioctl+0x42/0x270 and ending at do_IRQ+0xec/0x130
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at dnotify_parent+0x27/0xc0 and ending at dnotify_parent+0x85/0xc0
2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at buffered_rmqueue+0xea/0x190 and ending at 
buffered_rmqueue+0x144/0x190

What I've excluded (happens all the time):

1) 2ms non-preemptible critical section violated 1 ms preempt threshold 
starting at schedule+0x36/0x480 and ending at do_IRQ+0xec/0x130
it's 2ms 98%. This really happens all the time. Bogus?

2) 49ms non-preemptible critical section violated 1 ms preempt threshold 
starting at sys_ioctl+0x42/0x270 and ending at sys_ioctl+0xbd/0x270
40-50 ms most of the time, 12 ms couple of times.

Let me now if you need those traces for some of these (I've built kernel 
with 8K stacks).

Lenar

William Lee Irwin III wrote:

>This patch uses the preemption counter increments and decrements to time
>non-preemptible critical sections.
>  
>

