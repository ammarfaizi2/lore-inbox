Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVATXOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVATXOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVATXOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:14:43 -0500
Received: from cpanel02.rubas.net ([62.216.182.2]:12948 "EHLO
	cpanel02.rubas.net") by vger.kernel.org with ESMTP id S262215AbVATXMw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:12:52 -0500
Subject: inotify-0.18-rml-4: Oops
From: Juerg Billeter <j@bitron.ch>
To: linux-kernel@vger.kernel.org
Cc: rml@novell.com
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Jan 2005 00:12:51 +0100
Message-Id: <1106262771.10477.10.camel@juerg-t40p.bitron.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel02.rubas.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - bitron.ch
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I reproducibly get the following Oops as soon as I start using inotify
with gamin and/or beagle. This happens with linux 2.6.10-as1 + inotify
0.18-rml-4 on multiple x86 machines.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01d6d31
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: nfs lockd sunrpc mga af_packet autofs4 md5 ipv6 e100 mii
snd_cmipci snd_opl3_lib snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device
intel_agp agpgart snd_intel8x0 snd_ac97_codec tun snd_pcm_oss snd_pcm snd_timer
snd_page_alloc snd_mixer_oss snd soundcore ext3 jbd mbcache binfmt_misc xfs
sd_mod pl2303 usbserial ide_cd cdrom ide_disk aic7xxx scsi_mod piix ide_core
ehci_hcd uhci_hcd usbcore
CPU:    0
EIP:    0060:[inotify_dev_queue_event+353/368]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-paldo4) 
EIP is at inotify_dev_queue_event+0x161/0x170
eax: 00000000   ebx: d7a50f00   ecx: 00000003   edx: c6c7a2cc
esi: 00000000   edi: 00000000   ebp: 00000020   esp: c8b6bf6c
ds: 007b   es: 007b   ss: 0068
Process multiload-apple (pid: 2756, threadinfo=c8b6a000 task=e76bc020)
Stack: c014b27d 00000000 00000000 00000000 ddc822e8 ddc822e8 cbda31ac 00000000 
       00000020 c01d72c9 00000000 00000000 00000024 d8dd3980 f7772000 c8b6a000 
       c015826f 00000000 b777e8fc b777e8fc 00008000 c0103029 b777e8fc 00000000 
Call Trace:
 [remove_vm_struct+93/144] remove_vm_struct+0x5d/0x90
 [inotify_inode_queue_event+73/128] inotify_inode_queue_event+0x49/0x80
 [sys_open+95/176] sys_open+0x5f/0xb0
 [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
Code: 24 18 8b 7c 24 1c 8b 6c 24 20 83 c4 24 c3 c7 04 24 00 00 00 00 8b 4c 24
0c ba 00 40 00 00 b8 ff ff ff ff e9 3d ff ff ff 8b 42 18 <80> 38 00 eb bf 8d
76 00 8d bc 27 00 00 00 00 53 89 c3 8b 4b 20 
 <6>note: multiload-apple[2756] exited with preempt_count 1

I can provide more information on request.

Thanks for any advice

Jürg

(please cc me on replies)

-- 
Juerg Billeter <j@bitron.ch>

