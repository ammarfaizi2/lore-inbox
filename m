Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTLVFge (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 00:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbTLVFge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 00:36:34 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:6583 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264308AbTLVFg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 00:36:29 -0500
Date: Sun, 21 Dec 2003 21:36:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: cesarb@nitnet.com.br
Subject: [Bug 1714] New: divide error at snd_pcm_timer_resolution_change
Message-ID: <71240000.1072071378@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1714

           Summary: divide error at snd_pcm_timer_resolution_change
    Kernel Version: 2.6.0
            Status: NEW
          Severity: normal
             Owner: drivers_sound@kernel-bugs.osdl.org
         Submitter: cesarb@nitnet.com.br


Distribution: Debian testing/unstable
Hardware Environment: K7
Software Environment: wine 20031118, glibc 2.3.2.ds1-10
Problem Description:

Dec 20 23:27:22 flower kernel: can't create port
Dec 20 23:27:26 flower kernel: divide error: 0000 [#1]
Dec 20 23:27:26 flower kernel: CPU:    0
Dec 20 23:27:26 flower kernel: EIP:   
0060:[snd_pcm_timer_resolution_change+126/144]    Not tainted
Dec 20 23:27:26 flower kernel: EFLAGS: 00010246
Dec 20 23:27:26 flower kernel: EIP is at snd_pcm_timer_resolution_change+0x7e/0x90
Dec 20 23:27:26 flower kernel: eax: f4240000   ebx: 00008000   ecx: 00008000  
edx: 00000000
Dec 20 23:27:26 flower kernel: esi: 00000000   edi: f4240000   ebp: c35bdc00  
esp: c36b3bbc
Dec 20 23:27:26 flower kernel: ds: 007b   es: 007b   ss: 0068
Dec 20 23:27:26 flower kernel: Process wine.bin-pthrea (pid: 11613,
threadinfo=c36b2000 task=c1fc92a0)
Dec 20 23:27:26 flower kernel: Stack: 00000001 00008000 c35bdc00 00000001
c36b3c00 cfb77e40 c03ab619 cfb77e40
Dec 20 23:27:26 flower kernel:        c36b3c00 c35bd400 c36b3c00 cfb77e40
00000000 c03ab71f cfb77e40 c36b3c00
Dec 20 23:27:26 flower kernel:        0000025c 00000000 00000008 00000000
00000000 00000000 00000000 00000000
Dec 20 23:27:26 flower kernel: Call Trace:
Dec 20 23:27:26 flower kernel:  [snd_pcm_hw_params+505/656]
snd_pcm_hw_params+0x1f9/0x290
Dec 20 23:27:26 flower kernel:  [snd_pcm_hw_params_user+111/208]
snd_pcm_hw_params_user+0x6f/0xd0
Dec 20 23:27:26 flower kernel:  [snd_pcm_playback_ioctl1+100/1056]
snd_pcm_playback_ioctl1+0x64/0x420
Dec 20 23:27:26 flower kernel:  [snd_pcm_hw_param_near+498/656]
snd_pcm_hw_param_near+0x1f2/0x290
Dec 20 23:27:26 flower kernel:  [snd_pcm_kernel_playback_ioctl+56/80]
snd_pcm_kernel_playback_ioctl+0x38/0x50
Dec 20 23:27:26 flower kernel:  [snd_pcm_oss_change_params+1123/2160]
snd_pcm_oss_change_params+0x463/0x870
Dec 20 23:27:26 flower kernel:  [snd_pcm_oss_get_active_substream+79/96]
snd_pcm_oss_get_active_substream+0x4f/0x60
Dec 20 23:27:26 flower kernel:  [snd_pcm_oss_get_rate+23/48]
snd_pcm_oss_get_rate+0x17/0x30
Dec 20 23:27:26 flower kernel:  [snd_pcm_oss_ioctl+1680/1888]
snd_pcm_oss_ioctl+0x690/0x760
Dec 20 23:27:26 flower kernel:  [sys_ioctl+275/704] sys_ioctl+0x113/0x2c0
Dec 20 23:27:26 flower kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71
Dec 20 23:27:26 flower kernel:
Dec 20 23:27:26 flower kernel: Code: f7 f6 89 85 14 02 00 00 83 c4 08 5b 5e 5f
5d c3 89 f6 8b 44
Dec 20 23:28:22 flower kernel:  <3>can't create port
Dec 20 23:28:35 flower kernel: can't create port
Dec 20 23:28:37 flower kernel: divide error: 0000 [#2]
Dec 20 23:28:37 flower kernel: CPU:    0
Dec 20 23:28:37 flower kernel: EIP:   
0060:[snd_pcm_timer_resolution_change+126/144]    Not tainted
Dec 20 23:28:37 flower kernel: EFLAGS: 00010246
Dec 20 23:28:37 flower kernel: EIP is at snd_pcm_timer_resolution_change+0x7e/0x90
Dec 20 23:28:37 flower kernel: eax: f4240000   ebx: 00008000   ecx: 00008000  
edx: 00000000
Dec 20 23:28:37 flower kernel: esi: 00000000   edi: f4240000   ebp: ca666800  
esp: c09cfbbc
Dec 20 23:28:37 flower kernel: ds: 007b   es: 007b   ss: 0068
Dec 20 23:28:37 flower kernel: Process wine.bin-pthrea (pid: 11701,
threadinfo=c09ce000 task=c1fc8660)
Dec 20 23:28:37 flower kernel: Stack: 00000001 00008000 ca666800 00000001
c09cfc00 cfb77d80 c03ab619 cfb77d80
Dec 20 23:28:37 flower kernel:        c09cfc00 c52da000 c09cfc00 cfb77d80
00000000 c03ab71f cfb77d80 c09cfc00
Dec 20 23:28:37 flower kernel:        0000025c 00000000 00000008 00000000
00000000 00000000 00000000 00000000
Dec 20 23:28:37 flower kernel: Call Trace:
Dec 20 23:28:37 flower kernel:  [snd_pcm_hw_params+505/656]
snd_pcm_hw_params+0x1f9/0x290
Dec 20 23:28:37 flower kernel:  [snd_pcm_hw_params_user+111/208]
snd_pcm_hw_params_user+0x6f/0xd0
Dec 20 23:28:37 flower kernel:  [snd_pcm_playback_ioctl1+100/1056]
snd_pcm_playback_ioctl1+0x64/0x420
Dec 20 23:28:37 flower kernel:  [snd_pcm_hw_param_near+498/656]
snd_pcm_hw_param_near+0x1f2/0x290
Dec 20 23:28:37 flower kernel:  [snd_pcm_kernel_playback_ioctl+56/80]
snd_pcm_kernel_playback_ioctl+0x38/0x50
Dec 20 23:28:37 flower kernel:  [snd_pcm_oss_change_params+1123/2160]
snd_pcm_oss_change_params+0x463/0x870
Dec 20 23:28:37 flower kernel:  [snd_pcm_oss_get_active_substream+79/96]
snd_pcm_oss_get_active_substream+0x4f/0x60
Dec 20 23:28:37 flower kernel:  [snd_pcm_oss_get_rate+23/48]
snd_pcm_oss_get_rate+0x17/0x30
Dec 20 23:28:37 flower kernel:  [snd_pcm_oss_ioctl+1680/1888]
snd_pcm_oss_ioctl+0x690/0x760
Dec 20 23:28:37 flower kernel:  [sys_ioctl+275/704] sys_ioctl+0x113/0x2c0
Dec 20 23:28:37 flower kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71
Dec 20 23:28:37 flower kernel: 
Dec 20 23:28:37 flower kernel: Code: f7 f6 89 85 14 02 00 00 83 c4 08 5b 5e 5f
5d c3 89 f6 8b 44
Dec 20 23:28:58 flower kernel:  hda: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Dec 20 23:37:20 flower kernel: can't create port
Dec 20 23:37:21 flower kernel: divide error: 0000 [#3]
Dec 20 23:37:21 flower kernel: CPU:    0
Dec 20 23:37:21 flower kernel: EIP:   
0060:[snd_pcm_timer_resolution_change+126/144]    Not tainted
Dec 20 23:37:21 flower kernel: EFLAGS: 00010246
Dec 20 23:37:21 flower kernel: EIP is at snd_pcm_timer_resolution_change+0x7e/0x90
Dec 20 23:37:21 flower kernel: eax: f4240000   ebx: 00008000   ecx: 00008000  
edx: 00000000
Dec 20 23:37:21 flower kernel: esi: 00000000   edi: f4240000   ebp: ca666400  
esp: c72edbbc
Dec 20 23:37:21 flower kernel: ds: 007b   es: 007b   ss: 0068
Dec 20 23:37:21 flower kernel: Process wine.bin-pthrea (pid: 11934,
threadinfo=c72ec000 task=cc9980c0)
Dec 20 23:37:21 flower kernel: Stack: 00000001 00008000 ca666400 00000001
c72edc00 cfb77cc0 c03ab619 cfb77cc0
Dec 20 23:37:21 flower kernel:        c72edc00 c8cbf400 c72edc00 cfb77cc0
00000000 c03ab71f cfb77cc0 c72edc00
Dec 20 23:37:21 flower kernel:        0000025c 00000000 00000008 00000000
00000000 00000000 00000000 00000000
Dec 20 23:37:21 flower kernel: Call Trace:
Dec 20 23:37:21 flower kernel:  [snd_pcm_hw_params+505/656]
snd_pcm_hw_params+0x1f9/0x290
Dec 20 23:37:21 flower kernel:  [snd_pcm_hw_params_user+111/208]
snd_pcm_hw_params_user+0x6f/0xd0
Dec 20 23:37:21 flower kernel:  [snd_pcm_playback_ioctl1+100/1056]
snd_pcm_playback_ioctl1+0x64/0x420
Dec 20 23:37:21 flower kernel:  [snd_pcm_hw_param_near+498/656]
snd_pcm_hw_param_near+0x1f2/0x290
Dec 20 23:37:21 flower kernel:  [snd_pcm_kernel_playback_ioctl+56/80]
snd_pcm_kernel_playback_ioctl+0x38/0x50
Dec 20 23:37:21 flower kernel:  [snd_pcm_oss_change_params+1123/2160]
snd_pcm_oss_change_params+0x463/0x870
Dec 20 23:37:21 flower kernel:  [snd_pcm_oss_get_active_substream+79/96]
snd_pcm_oss_get_active_substream+0x4f/0x60
Dec 20 23:37:21 flower kernel:  [snd_pcm_oss_get_rate+23/48]
snd_pcm_oss_get_rate+0x17/0x30
Dec 20 23:37:21 flower kernel:  [snd_pcm_oss_ioctl+1680/1888]
snd_pcm_oss_ioctl+0x690/0x760
Dec 20 23:37:21 flower kernel:  [sys_ioctl+275/704] sys_ioctl+0x113/0x2c0
Dec 20 23:37:21 flower kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71
Dec 20 23:37:21 flower kernel: 
Dec 20 23:37:21 flower kernel: Code: f7 f6 89 85 14 02 00 00 83 c4 08 5b 5e 5f
5d c3 89 f6 8b 44


Steps to reproduce:
I was playing with wine and some random games. I don't know if I can reproduce it.

# CONFIG_SND_DEBUG is not set

If I understand correctly, even without CONFIG_SND_DEBUG it should handle bogus
values gracefully. Looks like it's not checking the input enough (maybe in
snd_pcm_hw_params_user).


