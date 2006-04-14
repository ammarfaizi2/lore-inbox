Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWDNVsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWDNVsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWDNVsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:48:23 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:5086 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965186AbWDNVsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:48:22 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: ALSA devel <alsa-devel@alsa-project.org>
Subject: ALSA CVS - pcm_oss.c:1872: BUG?
Date: Fri, 14 Apr 2006 17:48:15 -0400
User-Agent: KMail/1.9.1
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604141748.15367.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the below BUG in dmesg once or twice a day. Running snd_hda_intel on 
2.6.16 along with yesterday's ALSA CVS. 

Parag

[17197574.124000]  [<f89d8ad3>] snd_pcm_oss_get_active_substream+0x5d/0x7e 
[snd_pcm_oss]
[17197574.124000]  [<f89d9011>] snd_pcm_oss_ioctl+0x346/0x9c9 [snd_pcm_oss]
[17197574.128000]  [<7815ca79>] do_ioctl+0x21/0x5f
[17197574.128000]  [<7815cd07>] vfs_ioctl+0x250/0x263
[17197574.128000]  [<7815cd60>] sys_ioctl+0x46/0x62
[17197574.128000]  [<78102797>] sysenter_past_esp+0x54/0x75
[17197574.128000] ALSA /root/alsa/alsa-driver/acore/oss/pcm_oss.c:1872: BUG? 
(substream != ((void *)0))
[17197574.128000]  [<f89d8376>] snd_pcm_oss_release+0x37/0xda [snd_pcm_oss]
[17197574.128000]  [<7814df15>] __fput+0x86/0x14a
[17197574.128000]  [<7814baaa>] filp_close+0x4e/0x57
[17197574.128000]  [<7814c4a7>] sys_close+0x6b/0x80
[17197574.128000]  [<78102797>] sysenter_past_esp+0x54/0x75

