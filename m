Return-Path: <linux-kernel-owner+w=401wt.eu-S965110AbWLTOr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWLTOr7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWLTOr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:47:59 -0500
Received: from smtp.nildram.co.uk ([195.149.33.74]:37824 "EHLO
	smtp.nildram.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965115AbWLTOr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:47:58 -0500
X-Greylist: delayed 1609 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 09:47:58 EST
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Oops in 2.6.19.1
Date: Wed, 20 Dec 2006 14:21:03 +0000
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612201421.03514.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any ideas?

BUG: unable to handle kernel NULL pointer dereference at virtual address 
00000009
 printing eip:
c0156f60
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: ipt_recent ipt_REJECT xt_tcpudp ipt_MASQUERADE iptable_nat 
xt_state iptable_filter ip_tables x_tables prism54 yenta_socket 
rsrc_nonstatic pcmcia_core snd_via82xx snd_ac97_codec snd_ac97_bus snd_pcm 
snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd soundcore ehci_hcd 
usblp eth1394 uhci_hcd usbcore ohci1394 ieee1394 via_agp agpgart vt1211 
hwmon_vid hwmon ip_nat_ftp ip_nat ip_conntrack_ftp ip_conntrack
CPU:    0
EIP:    0060:[<c0156f60>]    Not tainted VLI
EFLAGS: 00010246   (2.6.19.1 #1)
EIP is at pipe_poll+0xa0/0xb0
eax: 00000008   ebx: 00000000   ecx: 00000008   edx: 00000000
esi: f70f3e9c   edi: f7017c00   ebp: f70f3c1c   esp: f70f3c0c
ds: 007b   es: 007b   ss: 0068
Process python (pid: 4178, ti=f70f2000 task=f70c4a90 task.ti=f70f2000)
Stack: 00000000 00000000 f70f3e9c f6e111c0 f70f3fa4 c015d7f3 f70f3c54 f70f3fac
       084c44a0 00000030 084c44d0 00000000 f70f3e94 f70f3e94 00000006 f70f3ecc
       00000000 f70f3e94 c015e580 00000000 00000000 00000006 f6e111c0 00000000
Call Trace:
 [<c015d7f3>] do_sys_poll+0x253/0x480
 [<c015da53>] sys_poll+0x33/0x50
 [<c0102c97>] syscall_call+0x7/0xb
 [<b7f6b402>] 0xb7f6b402
 =======================
Code: 58 01 00 00 0f 4f c2 09 c1 89 c8 83 c8 08 85 db 0f 44 c8 8b 5d f4 89 c8 
8b 75 f8 8b 7d fc 89 ec 5d c3 89 ca 8b 46 6c 83 ca 10 3b <87> 68 01 00 00 0f 
45 ca eb b6 8d b6 00 00 00 00 55 b8 01 00 00
EIP: [<c0156f60>] pipe_poll+0xa0/0xb0 SS:ESP 0068:f70f3c0c

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
