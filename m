Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUJOH1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUJOH1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 03:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUJOH1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 03:27:15 -0400
Received: from [62.149.128.225] ([62.149.128.225]:15268 "HELO smtpa2.aruba.it")
	by vger.kernel.org with SMTP id S266427AbUJOHWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 03:22:52 -0400
Message-ID: <416F7B84.2040401@alessandro.vincelli.name>
Date: Fri, 15 Oct 2004 09:25:56 +0200
From: Alessandro Vincelli <tigre@alessandro.vincelli.name>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040920)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: inux-2.6.9-rc4-mm1 -> apache2[9125] exited with preempt_count 2 
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Rating: smtpa2.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the kernel linux-2.6.9-rc4-mm1 after start apache2 the stack repeat 
the error before.
with the kernel < 2.6.9 no problem.
I use gentoo,
and this modules

bash-2.05b$ cat /proc/mo
modules  mounts
bash-2.05b$ cat /proc/modules
uhci_hcd 25624 - - Live 0xcee5e000
snd_atiixp 14216 - - Live 0xcee3a000
snd_ac97_codec 58732 - - Live 0xcee4e000
ehci_hcd 22188 - - Live 0xcee33000
ati_agp 5844 - - Live 0xced95000
usbcore 88832 - - Live 0xcee14000
ntfs 86676 - - Live 0xcedc1000
3c59x 32464 - - Live 0xced9d000


why?



Unable to handle kernel paging request at virtual address 000153bc
printing eip:
c011537f
*pde = 00000000
Oops: 0002 [#182]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c011537f>]    Not tainted VLI
EFLAGS: 00210082   (2.6.9-rc4-mm1)
EIP is at profile_hit+0x23/0x26
eax: 00000000   ebx: c1ec2a00   ecx: 00000000   edx: 000153bc
esi: ffffffea   edi: 00000000   ebp: c18f1fbc   esp: c18f1f98
ds: 007b   es: 007b   ss: 0068
Process apache2 (pid: 9124, threadinfo=c18f0000 task=c1ec2a00)
Stack: c0111c2c c041f5a0 b7c60b84 c18f0000 00200086 00000000 000023a4 
00000000
      00000000 c18f0000 c0105717 000023a4 00000000 b6599cf8 00000000 
00000000
      b6599bcc 0000009c 0000007b 0000007b 0000009c b7be3144 00000073 
00200246
Call Trace:
[<c0111c2c>] setscheduler+0xa4/0x1f0
[<c0105717>] syscall_call+0x7/0xb
Code: 8b 74 24 04 83 c4 10 c3 81 ea 28 02 10 c0 8b 0d 2c 48 42 c0 a1 28 
48 42 c0 d3 ea 83 e8 01 39 d0 0f 46 d0 a1 24 48 42 c0 8d 14 90 <ff> 02 
c3 b8 da ff ff ff c3 b8 da ff ff ff c3 90 90 53 31 d2 83
<6>note: apache2[9124] exited with preempt_count 2
Unable to handle kernel paging request at virtual address 000153bc
printing eip:
c011537f
*pde = 00000000
Oops: 0002 [#183]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c011537f>]    Not tainted VLI
EFLAGS: 00210082   (2.6.9-rc4-mm1)
EIP is at profile_hit+0x23/0x26
eax: 00000000   ebx: c1ec2510   ecx: 00000000   edx: 000153bc
esi: ffffffea   edi: 00000000   ebp: c18c3fbc   esp: c18c3f98
ds: 007b   es: 007b   ss: 0068
Process apache2 (pid: 9125, threadinfo=c18c2000 task=c1ec2510)
Stack: c0111c2c c041f5a0 b7c60b84 c18c2000 00200082 00000000 000023a5 
00000000
      00000000 c18c2000 c0105717 000023a5 00000000 b6599cf8 00000000 
00000000
      b6599bcc 0000009c 0000007b 0000007b 0000009c b7be3144 00000073 
00200246
Call Trace:
[<c0111c2c>] setscheduler+0xa4/0x1f0
[<c0105717>] syscall_call+0x7/0xb
Code: 8b 74 24 04 83 c4 10 c3 81 ea 28 02 10 c0 8b 0d 2c 48 42 c0 a1 28 
48 42 c0 d3 ea 83 e8 01 39 d0 0f 46 d0 a1 24 48 42 c0 8d 14 90 <ff> 02 
c3 b8 da ff ff ff c3 b8 da ff ff ff c3 90 90 53 31 d2 83
<6>note: apache2[9125] exited with preempt_count 2

-- 
-------------------------------
Alessandro Vincelli 
W4B - web for business s.r.l.
Firenze 
via Pellicceria 10 - 50123
E-mail: a.vincelli@w4b.it
tel: 055-2654270 

