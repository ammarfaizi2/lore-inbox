Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261507AbSJAHbB>; Tue, 1 Oct 2002 03:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261510AbSJAHbB>; Tue, 1 Oct 2002 03:31:01 -0400
Received: from [203.117.131.12] ([203.117.131.12]:44705 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261507AbSJAHa7>; Tue, 1 Oct 2002 03:30:59 -0400
Message-ID: <3D995073.10706@metaparadigm.com>
Date: Tue, 01 Oct 2002 15:36:19 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.39 bad schedule while atomic [alsa/intel8x0]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System keeps running fine, but keep getting this message
dumped to my kernel log every minute or so.

Would any of the recent alsa patches fix this problem?

~mc

bad: scheduling while atomic!
e4835c7c c01197b1 c032c440 e4835cc4 00b9904c 00b99063 e48a4080 efbeaf40
        efbeae00 c02c6afe 00000202 e4835cc4 00b9904c 0000002c c0128ee8 e4835cc4
        e4834000 00000002 c0490304 ebd57f2c 00b9904c e48a4080 c0128e5c c02cc1fe
Call Trace:
  [<c01197b1>]schedule+0x3d/0x4e4
  [<c02c6afe>]snd_intel8x0_codec_read+0x56/0x110
  [<c0128ee8>]schedule_timeout+0x80/0xa0
  [<c0128e5c>]process_timeout+0x0/0xc
  [<c02cc1fe>]snd_ac97_set_rate+0x182/0x1a0
  [<c02c7377>]snd_intel8x0_playback_prepare+0xe7/0xfc
  [<c02a9624>]snd_pcm_prepare+0x1cc/0x2dc
  [<c02ab9e6>]snd_pcm_common_ioctl1+0x1ca/0x37c
  [<c02abfb6>]snd_pcm_playback_ioctl1+0x41e/0x42c
  [<c0119d7a>]__wake_up+0x5e/0xb0
  [<c0119db9>]__wake_up+0x9d/0xb0
  [<c0270ae1>]mousedev_event+0x251/0x26c
  [<c026f5dd>]input_event+0x36d/0x380
  [<c0271cf9>]psmouse_process_packet+0x289/0x290
  [<c0271e34>]psmouse_interrupt+0x134/0x160
  [<c02729a7>]serio_interrupt+0x23/0x38
  [<c0118bdb>]wake_up_process+0xb/0x10
  [<c0129fdf>]deliver_signal+0x5f/0x68
  [<c012a179>]__send_sig_info+0x191/0x21c
  [<c012a7f0>]send_sig_info+0x348/0x3ac
  [<c012aa35>]kill_proc_info+0x55/0x7c
  [<c012ab60>]kill_something_info+0x104/0x10c
  [<c012bcbc>]sys_kill+0x54/0x5c
  [<c012524e>]bh_action+0x3a/0xa4
  [<c0125135>]tasklet_hi_action+0x85/0xe0
  [<c02ac2f8>]snd_pcm_playback_ioctl+0x20/0x30
  [<c015fdab>]sys_ioctl+0x27f/0x2f5
  [<c0109057>]syscall_call+0x7/0xb


