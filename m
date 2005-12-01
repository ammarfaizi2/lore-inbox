Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVLACUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVLACUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 21:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVLACUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 21:20:16 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:65475 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751345AbVLACUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 21:20:14 -0500
From: Ismail Donmez <ismail@uludag.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
To: linux-kernel@vger.kernel.org
Subject: More 2.6.15-rc3 problems
Date: Thu, 1 Dec 2005 04:19:47 +0200
User-Agent: KMail/1.8.92
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512010419.48394.ismail@uludag.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like gdb doesn't work with 2.6.15-rc3 kernel. Trying to run ls or any 
other binary crashes gdb and ooopses kernel. Here is the log :

 <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000015
 printing eip:
c014ac54
*pde = 00000000
Oops: 0000 [#8]
PREEMPT
Modules linked in: i915 drm ohci_hcd e100 mii ipw2200 ieee80211 
ieee80211_crypt firmware_class ohci1394 ieee1394 yenta_socket rsrc_nonstatic 
pcmcia_core i2c_i801 i2c_core ehci_hcd usbhid uhci_hcd intel_agp agpgart 
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss 
snd_mixer_oss usbcore snd_hda_intel snd_hda_codec snd_pcm snd_timer snd 
snd_page_alloc
CPU:    0
EIP:    0060:[<c014ac54>]    Not tainted VLI
EFLAGS: 00210202   (2.6.15-rc3)
EIP is at vm_normal_page+0x14/0x60
eax: 1f6c4025   ebx: 00000000   ecx: 00000000   edx: 0001f6c4
esi: 1f6c4025   edi: ffffe000   ebp: 00000010   esp: d347eeec
ds: 007b   es: 007b   ss: 0068
Process gdb (pid: 29619, threadinfo=d347e000 task=ce7f1a50)
Stack: 00000ff8 c0513700 ffffe000 c014b9d9 00000000 ffffe000 1f6c4025 00000000
       d8b34a90 bfab1dcc d8b34a90 d347ef84 c0124e67 d8b34a90 de941e40 ffffe000
       00000001 00000000 00000001 d347ef4c d347ef50 de941e70 d347ef84 de941e40
Call Trace:
 [<c014b9d9>] get_user_pages+0x229/0x290
 [<c0124e67>] access_process_vm+0x77/0x140
 [<c0107441>] arch_ptrace+0x481/0x550
 [<c012d4c0>] find_task_by_pid_type+0x10/0x30
 [<c0125384>] ptrace_get_task_struct+0x74/0xb0
 [<c012541a>] sys_ptrace+0x5a/0x9b
 [<c0102f3b>] sysenter_past_esp+0x54/0x79
Code: 43 25 fd ff 83 c4 18 5b 5e 5f e9 48 97 fb ff 90 8d b4 26 00 00 00 00 57 
56 53 8b 5c 24 10 8b 74 24 18 89 f2 8b 7c 24 14 c1 ea 0c <f6> 43 15 04 74 15 
8b 4b 04 89 f8 29 c8 8b 4b 48 c1 e8 0c 01 c8


P.S: I am not subscribed. So CC me if you reply.

Regards,
ismail
