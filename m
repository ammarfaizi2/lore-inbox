Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKIBic>; Wed, 8 Nov 2000 20:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKIBiW>; Wed, 8 Nov 2000 20:38:22 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:65063 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129033AbQKIBiM>; Wed, 8 Nov 2000 20:38:12 -0500
Message-ID: <3A09FFFB.97E1C739@linux.com>
Date: Wed, 08 Nov 2000 17:38:03 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: OOPS loading cs46xx module, test11-pre1
Content-Type: multipart/mixed;
 boundary="------------3ADFB8A170D58EBFB9874638"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3ADFB8A170D58EBFB9874638
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Crystal 4280/461x + AC97 Audio, version 0.09, 16:07:04 Nov  8 2000
cs461x: Card found at 0xc7800000 and 0xc7000000, IRQ 11
cs461x: Voyetra at 0xc7800000/0xc7000000, IRQ 11
Unable to handle kernel paging request at virtual address a1d60878
 printing eip:
a1d60878
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<a1d60878>]
EFLAGS: 00010287
eax: 9192d469   ebx: 00000000   ecx: 00000246   edx: 00000000
esi: cf92e280   edi: cc18a000   ebp: cf92e280   esp: cc18bec8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 294, stackpage=cc18b000)
Stack: d091a06a d091c389 cf92e280 00030000 00000040 0001136a cf92e280
d091c8a3
       cf92e280 cf92e280 00000468 00000003 d092b0e8 c144a000 c7000000
d091cc36
       cf92e280 c144a000 00000000 00000001 00011254 50533357 d091ce8e
c144a000
Call Trace: [<d091a06a>] [<d091c389>] [<d091c8a3>] [<d092b0e8>]
[<d091cc36>] [<d091ce8e>] [<d091a000>]
       [<d091cefd>] [<c0117bf9>] [<d0917000>] [<d091a060>] [<c010aaff>]
Code:  Bad EIP value.


>From ksymoops 2.3.5:
>>EIP; a1d60878 Before first symbol   <=====
Trace; d091a06a <[cs46xx]cs461x_poke+16/2c>
Trace; d091c389 <[cs46xx]cs461x_reset+15/78>
Trace; d091c8a3 <[cs46xx]cs_hardware_init+23b/30c>
Trace; d092b0e8 <[cs46xx]cards+10/6f>
Trace; d091cc36 <[cs46xx]cs_install+2c2/368>
Trace; d091ce8e <[cs46xx]cs_probe+62/cc>
Trace; d091a000 <[cs46xx]__module_kernel_version+0/1c>
Trace; d091cefd <[cs46xx]init_module+5/1c>
Trace; c0117bf9 <sys_init_module+4ed/590>
Trace; d0917000 <[ac97_codec]__kstrtab_ac97_read_proc+0/0>
Trace; d091a060 <[cs46xx]cs461x_poke+c/2c>
Trace; c010aaff <system_call+33/38>

This is also the card that doesn't init if it's compiled in and only
works as a module.

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------3ADFB8A170D58EBFB9874638
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------3ADFB8A170D58EBFB9874638--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
