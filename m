Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271329AbTGWVHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 17:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271330AbTGWVHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 17:07:17 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:61598 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S271329AbTGWVHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 17:07:13 -0400
Date: Wed, 23 Jul 2003 23:22:18 +0200
From: Jan Killius <jkillius@arcor.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1-ac3 snd_usb_audio problem
Message-ID: <20030723212218.GA13903@gate.unimatrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test1-ac1 i586
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I have a little problem with the ALSA usb driver it doesn't work.
I think it is a general problem with the 2.6 kernel scheduler.
However i have attached some dmesg call trace output. 
This output comes if i try to play a audio file...
-- 
Greets
Jan Killius

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=calltrace

bad: scheduling while atomic!
Call Trace:
 [<c01199d9>] schedule+0x3a9/0x3b0
 [<c01251ff>] schedule_timeout+0x5f/0xc0
 [<c0125190>] process_timeout+0x0/0x10
 [<c0260217>] usb_start_wait_urb+0xb7/0x1a0
 [<c0119a40>] default_wake_function+0x0/0x30
 [<c026036b>] usb_internal_control_msg+0x6b/0x80
 [<c0260416>] usb_control_msg+0x96/0xb0
 [<c0260f21>] usb_set_interface+0xc1/0x220
 [<c025f9c0>] hcd_endpoint_disable+0x0/0x1a0
 [<e493843f>] set_format+0xbf/0x2b0 [snd_usb_audio]
 [<e4938694>] snd_usb_pcm_prepare+0x34/0x50 [snd_usb_audio]
 [<e49239b4>] snd_pcm_do_prepare+0x14/0x40 [snd_pcm]
 [<e4922e09>] snd_pcm_action_single+0x39/0x70 [snd_pcm]
 [<e4922f58>] snd_pcm_action_lock_irq+0x98/0xa0 [snd_pcm]
 [<e4923a71>] snd_pcm_prepare+0x61/0x80 [snd_pcm]
 [<e492631e>] snd_pcm_playback_ioctl1+0x5e/0x450 [snd_pcm]
 [<c01250b0>] do_timer+0xe0/0xf0
 [<c0162893>] sys_ioctl+0xf3/0x280
 [<c0118040>] do_page_fault+0x0/0x453
 [<c010918b>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c01199d9>] schedule+0x3a9/0x3b0
 [<c01251ff>] schedule_timeout+0x5f/0xc0
 [<c0125190>] process_timeout+0x0/0x10
 [<c0260217>] usb_start_wait_urb+0xb7/0x1a0
 [<c0119a40>] default_wake_function+0x0/0x30
 [<c026036b>] usb_internal_control_msg+0x6b/0x80
 [<c0260416>] usb_control_msg+0x96/0xb0
 [<e49382a6>] init_usb_sample_rate+0xb6/0x190 [snd_usb_audio]
 [<c025f9c0>] hcd_endpoint_disable+0x0/0x1a0
 [<e4938505>] set_format+0x185/0x2b0 [snd_usb_audio]
 [<e4938694>] snd_usb_pcm_prepare+0x34/0x50 [snd_usb_audio]
 [<e49239b4>] snd_pcm_do_prepare+0x14/0x40 [snd_pcm]
 [<e4922e09>] snd_pcm_action_single+0x39/0x70 [snd_pcm]
 [<e4922f58>] snd_pcm_action_lock_irq+0x98/0xa0 [snd_pcm]
 [<e4923a71>] snd_pcm_prepare+0x61/0x80 [snd_pcm]
 [<e492631e>] snd_pcm_playback_ioctl1+0x5e/0x450 [snd_pcm]
 [<c01250b0>] do_timer+0xe0/0xf0
 [<c0162893>] sys_ioctl+0xf3/0x280
 [<c0118040>] do_page_fault+0x0/0x453
 [<c010918b>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c01199d9>] schedule+0x3a9/0x3b0
 [<c01251ff>] schedule_timeout+0x5f/0xc0
 [<c0125190>] process_timeout+0x0/0x10
 [<c0260217>] usb_start_wait_urb+0xb7/0x1a0
 [<c0119a40>] default_wake_function+0x0/0x30
 [<c026036b>] usb_internal_control_msg+0x6b/0x80
 [<c0260416>] usb_control_msg+0x96/0xb0
 [<e4938302>] init_usb_sample_rate+0x112/0x190 [snd_usb_audio]
 [<c025f9c0>] hcd_endpoint_disable+0x0/0x1a0
 [<e4938505>] set_format+0x185/0x2b0 [snd_usb_audio]
 [<e4938694>] snd_usb_pcm_prepare+0x34/0x50 [snd_usb_audio]
 [<e49239b4>] snd_pcm_do_prepare+0x14/0x40 [snd_pcm]
 [<e4922e09>] snd_pcm_action_single+0x39/0x70 [snd_pcm]
 [<e4922f58>] snd_pcm_action_lock_irq+0x98/0xa0 [snd_pcm]
 [<e4923a71>] snd_pcm_prepare+0x61/0x80 [snd_pcm]
 [<e492631e>] snd_pcm_playback_ioctl1+0x5e/0x450 [snd_pcm]
 [<c01250b0>] do_timer+0xe0/0xf0
 [<c0162893>] sys_ioctl+0xf3/0x280
 [<c0118040>] do_page_fault+0x0/0x453
 [<c010918b>] syscall_call+0x7/0xb
--gBBFr7Ir9EOA20Yy--
