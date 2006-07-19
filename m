Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbWGSVoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWGSVoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 17:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWGSVoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 17:44:15 -0400
Received: from [85.112.98.194] ([85.112.98.194]:32695 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S932549AbWGSVoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 17:44:14 -0400
Date: Wed, 19 Jul 2006 22:01:00 +0400
From: Jim Klimov <klimov@2ka.mipt.ru>
X-Mailer: The Bat! (v2.10.01)         CD5BF9353B3B7091
Reply-To: Jim Klimov <klimov@2ka.mipt.ru>
Organization: MIPT Campus-Net
X-Priority: 3 (Normal)
Message-ID: <1117629729.20060719220100@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel paging request, 2.6.16.25 server reboots
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Wed, 19 Jul 2006 22:20:52 +0400 (MSD)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Wed, 19 Jul 2006 22:06:33 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

  A file server reboots casually (about once a day), possibly after
  a hardware change and/or kernel upgrades. Messages from netconsole
  from some prehistory till when it died.

  Possibly there's some roughness in new 3Ware controllers and two
  dozen harddisks on a 1200W power source, or it may actually be
  something in the kernel?

  Tell me if i need to send any more details to help find the cause?

[124596.814512] RAID1 conf printout:
[124596.818003]  --- wd:2 rd:2
[124596.820951]  disk 0, wo:0, o:1, dev:hdc6
[124596.825103]  disk 1, wo:0, o:1, dev:hda6
[125006.766476] RAID1 conf printout:
[125006.770034]  --- wd:2 rd:2
[125006.773045]  disk 0, wo:0, o:1, dev:hdc3
[125006.777355]  disk 1, wo:0, o:1, dev:hda3
[128327.901665] sd 1:0:0:0: WARNING: (0x06:0x002C): Command (0x28) timed out, resetting card.
[128349.097511] 3w-9xxx: scsi1: AEN: INFO (0x04:0x005E): Cache synchronization completed:unit=0.
[168963.589093] sd 1:0:0:0: WARNING: (0x06:0x002C): Command (0x28) timed out, resetting card.
[176346.288751] sd 1:0:0:0: WARNING: (0x06:0x002C): Command (0x28) timed out, resetting card.
[176729.038304] sd 1:0:0:0: WARNING: (0x06:0x002C): Command (0x88) timed out, resetting card.
[185981.945786] sd 1:0:0:0: WARNING: (0x06:0x002C): Command (0x88) timed out, resetting card.
[186001.941492] 3w-9xxx: scsi1: AEN: INFO (0x04:0x005E): Cache synchronization completed:unit=0.
[186996.079708] Unable to handle kernel paging request at virtual address f8fbee23
[186996.087681]  printing eip:
[186996.090769] c0359a1a
[186996.093380] *pde = 36a16067
[186996.096504] Oops: 0000 [#1]
[186996.099581] SMP 
[186996.101807] Modules linked in: w83781d hwmon_vid i2c_isa i2c_core w83627hf_wdt
[186996.110081] CPU:    0
[186996.110085] EIP:    0060:[<c0359a1a>]    Not tainted VLI
[186996.110089] EFLAGS: 00210282   (2.6.16.25 #2)
[186996.123098] EIP is at ipt_do_table+0xae/0x385
[186996.127762] eax: 00000003   ebx: 00000000   ecx: ecfffad8   edx: f8fbedd0
[186996.134997] esi: f0927cc0   edi: f8fbedd0   ebp: 80000000   esp: ef6efb2c
[186996.142317] ds: 007b   es: 007b   ss: 0068
[186996.146767] Process smbd (pid: 12183, threadinfo=ef6ee000 task=e0046570)
[186996.153704] Stack: <0>f29138d8 e8ed389c c032eac4 f7f60000 00000000 c042c0cc f8fbedd0 f8f91000
[186996.163740]        f7f60000 c04eb394 00000000 ecfffad8 00000000 00000003 ef6efc04 00000000
[186996.174592]        ef6efc04 00000003 c04e9798 80000000 c035b647 f7f60000 c042c0a0 00000000
[186996.184093] Call Trace:
[186996.186858]  [<c032eac4>] ip_output+0x15c/0x29c
[186996.191913]  [<c035b647>] ipt_local_out_hook+0x72/0x77
[186996.197536]  [<c03247b9>] nf_iterate+0x69/0x83
[186996.202372]  [<c033102a>] dst_output+0x0/0x7
[186996.207074]  [<c033102a>] dst_output+0x0/0x7
[186996.211735]  [<c0324830>] nf_hook_slow+0x5d/0xea
[186996.216699]  [<c033102a>] dst_output+0x0/0x7
[186996.221376]  [<c032efd8>] ip_queue_xmit+0x3d4/0x4f5
[186996.226656]  [<c033102a>] dst_output+0x0/0x7
[186996.231329]  [<c030e46e>] sk_reset_timer+0xc/0x16
[186996.236556]  [<c033b49d>] tcp_clean_rtx_queue+0x432/0x464
[186996.242508] tcp_cong_avoid+0x27/0x3e[186996.353130]
...
[4294667.296000] Linux version 2.6.16.25 (root@XXX.mipt.ru)
(gcc version 3.2.3) #2 SMP Sun Jul 16 00:39:52 MSD 2006

  PS: why is the kernel time so strange during boot messages?
  It resets at least 3 times before point zero...

-- 
Best regards,
 Jim Klimov                          mailto:klimov@2ka.mipt.ru

