Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVAQB0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVAQB0o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 20:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVAQB0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 20:26:44 -0500
Received: from asmtp04.eresmas.com ([62.81.235.144]:18862 "EHLO
	asmtp04.eresmas.com") by vger.kernel.org with ESMTP id S262662AbVAQB01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 20:26:27 -0500
From: "man_josewanadoo.es" <man_jose@wanadoo.es>
To: linux-kernel@vger.kernel.org
Subject: RE: Re: Kernel bug: mm/rmap.c:483
Date: Mon, 17 Jan 2005 02:26:24 +0100
X-MAILER: ARB/3.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1CqLez-0004PX-05@mb09.local>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to send the next post to:
"Frank Denis \(Jedi/Sector One\)" j@pureftpd.org


But  my email provider doesn't let me to send this message to: j@pureftpd.org
It's about a bug.
-------------------
Hello Frank,
I supose that I should write to you directly, or am I wrong? Besides, I'm Spanish, so please sorry my english.
The 2.6.11-rc1-mm1-jedi1 keeps on failing. Disclaimer : I'm a newbie. This is the first time I patch something. And this friday was my first contact with Gentoo, ebuilds, emerge and all those things  (I came from Mandrake 10.1 because I feel that there was something working bad).


What I have done (is it OK?):
tar -xvjpf linux-2.6.11-rc1
bzip2 -dc 2.6.11-rc1-mm1.bz2 | patch -p1
bzip2 -dc 2.6.11-rc1-mm1-jedi1.batch.z2 | patch -p1


Everything works fine, but when I do "emerge eagle-usb":
------------[ cut here ]------------
kernel BUG at mm/rmap.c:482!
invalid operand: 0000 [#2]
Modules linked in: rtc
CPU:    0
EIP:    0060:[<c0146aa9>]    Not tainted VLI
EFLAGS: 00010296   (2.6.11-rc1-mm1-jedi1)
EIP is at page_remove_rmap+0x29/0x40
eax: fffffff0   ebx: 0000d000   ecx: c1205020   edx: c1205020
esi: cee7834c   edi: c1205020   ebp: 00025000   esp: d1306e6c
ds: 007b   es: 007b   ss: 0068
Process doman (pid: 12367, threadinfo=d1306000 task=cf46c0c0)
Stack: c0140218 c1205020 00000000 0f014067 40417000 10281067 084c6000 d0c3c084
       080eb000 00000000 c0140383 c04f9028 d0c3c080 080c6000 00025000 00000000
       080c6000 d0c3c084 080eb000 00000000 c01403da c04f9028 d0c3c080 080c6000
Call Trace:
 [<c0140218>] zap_pte_range+0x128/0x240
 [<c0140383>] zap_pmd_range+0x53/0x70
 [<c01403da>] zap_pud_range+0x3a/0x60
 [<c0140470>] unmap_page_range+0x70/0x90
 [<c0140586>] unmap_vmas+0xf6/0x1f0
 [<c0144d88>] exit_mmap+0x78/0x140
 [<c0113da7>] mmput+0x37/0xd0
 [<c0118047>] do_exit+0xa7/0x330
 [<c0118344>] do_group_exit+0x34/0x70
 [<c010304f>] syscall_call+0x7/0xb
Code: 26 00 8b 54 24 04 8b 02 f6 c4 08 75 28 83 42 08 ff 0f 98 c0 84 c0 74 11 8b 42 08 40 78 0d 9c 58 fa ff 0d 50 61 50 c0 50 9d 90 c3 <0f> 0b e2 01 a0 ae 3d c0 eb e9 0f 0b df 01 a0 ae 3d c0 eb ce 8d
 BUG: atomic counter underflow at:
 [<c0118258>] do_exit+0x2b8/0x330
 [<c0103cf0>] do_invalid_op+0x0/0xd0
 [<c0103cf0>] do_invalid_op+0x0/0xd0
 [<c0103930>] do_trap+0x0/0x110
 [<c0103d9e>] do_invalid_op+0xae/0xd0
 [<c0146aa9>] page_remove_rmap+0x29/0x40
 [<c0136ea2>] prep_new_page+0x52/0x60
 [<c0137594>] buffered_rmqueue+0xe4/0x200
 [<c0136ea2>] prep_new_page+0x52/0x60
 [<c01031f7>] error_code+0x2b/0x30
 [<c0146aa9>] page_remove_rmap+0x29/0x40
 [<c0140218>] zap_pte_range+0x128/0x240
 [<c0140383>] zap_pmd_range+0x53/0x70
 [<c01403da>] zap_pud_range+0x3a/0x60
 [<c0140470>] unmap_page_range+0x70/0x90
 [<c0140586>] unmap_vmas+0xf6/0x1f0
 [<c0144d88>] exit_mmap+0x78/0x140
 [<c0113da7>] mmput+0x37/0xd0
 [<c0118047>] do_exit+0xa7/0x330
 [<c0118344>] do_group_exit+0x34/0x70
 [<c010304f>] syscall_call+0x7/0xb
















----- Mensaje Original -----
Remitente: "Frank Denis \(Jedi/Sector One\)" j@pureftpd.org
Destinatario: "man_josewanadoo.es" man_jose@wanadoo.es
Fecha: Domingo, Enero 16, 2005 10:23pm
Asunto: Re: Kernel bug: mm/rmap.c:483


>On Sun, Jan 16, 2005 at 10:12:21PM +0100, man_josewanadoo.es wrote:
>> What is next is with the kernel-2.6.10-r4
>> Would you post me to say if the bug is closed or if is my system 
>who is broken?
>> kernel BUG at mm/rmap.c:483!
> Your system is not broken, this is a known bug.
> 
> Can you check whether 2.6.11-rc1-mm1-jedi1 fixes it?
> 
> 2.6.11-rc1 : ftp://ftp.kernel.org:/pub/linux/kernel/v2.6/testing/
> -mm1 patch : ftp://ftp.kernel.org:/pub/linux/kernel/people/akpm/
>patches/2.6/
> -jedi1     : ftp://ftp.c9x.org/linux-kernel/
> Best regards,
>-- 
>Frank - my st
