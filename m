Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132347AbQK3Abv>; Wed, 29 Nov 2000 19:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132369AbQK3Abl>; Wed, 29 Nov 2000 19:31:41 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:10023 "EHLO
        nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
        id <S132347AbQK3Abc>; Wed, 29 Nov 2000 19:31:32 -0500
Message-ID: <3A255CEB.A598A811@linux.com>
Date: Wed, 29 Nov 2000 11:45:47 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [oops] test12-2, yet another apm related oops
Content-Type: multipart/mixed;
 boundary="------------0CC8B5F9752F43CD50B4658F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0CC8B5F9752F43CD50B4658F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Unable to handle kernel NULL pointer dereference at virtual address
000000fc
c02b3527
*pde = 02253067
Oops: 0000
CPU:    0
EIP:    0010:[<c02b3527>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010293
eax: 00000000   ebx: c90cb800   ecx: c03826a8   edx: 00000001
esi: 00000003   edi: c13a4400   ebp: 00000000   esp: cbf7bf00
ds: 0018   es: 0018   ss: 0018
Process kapm-idled (pid: 2, stackpage=cbf7b000)
Stack: bcbc2507 00000000 c90cb800 c02b7894 bcbc2507 c90cb800 00000001
c13a4200
       c0253c9a c90cb800 c13a4200 00000003 00000000 c0253e61 c0253e79
c13a4400
       cbf07be0 c0253f06 c13a4200 c0115d71 cbf07be0 00000000 00000003
cbf07bfc
Call Trace: [<c02b7894>] [<c0253c9a>] [<c0253e61>] [<c0253e79>]
[<c0253f06>] [<c0115d71>] [<c0115e05>]
       [<c0110d19>] [<c0110f6b>] [<c011108b>] [<c0111155>] [<c02e603c>]
[<c0111a5a>] [<c01095db>] [<c01095e4>]
Code: 8b 80 fc 00 00 00 50 e8 b1 b9 00 00 89 c3 83 c4 0c 85 db 74
>>EIP; c02b3527 <irlmp_unregister_link+23/98>   <=====
Trace; c02b7894 <irlap_close+78/c0>
Trace; c0253c9a <nsc_ircc_net_close+92/100>
Trace; c0253e61 <nsc_ircc_suspend+15/3c>
Trace; c0253e79 <nsc_ircc_suspend+2d/3c>
Trace; c0253f06 <nsc_ircc_pmproc+22/30>
Trace; c0115d71 <pm_send+2d/58>
Trace; c0115e05 <pm_send_all+2d/5c>
Trace; c0110d19 <send_event+21/70>
Trace; c0110f6b <check_events+f7/19c>
Trace; c011108b <apm_event_handler+7b/7c>
Trace; c0111155 <apm_mainloop+c9/100>
Trace; c02e603c <error_table+4f8/39a4>
Trace; c0111a5a <apm+28a/29c>
Trace; c01095db <kernel_thread+1f/38>
Trace; c01095e4 <kernel_thread+28/38>
Code;  c02b3527 <irlmp_unregister_link+23/98>
00000000 <_EIP>:
Code;  c02b3527 <irlmp_unregister_link+23/98>   <=====
   0:   8b 80 fc 00 00 00         mov    0xfc(%eax),%eax   <=====
Code;  c02b352d <irlmp_unregister_link+29/98>
   6:   50                        push   %eax
Code;  c02b352e <irlmp_unregister_link+2a/98>
   7:   e8 b1 b9 00 00            call   b9bd <_EIP+0xb9bd> c02beee4
<hashbin_remove+0/17c>
Code;  c02b3533 <irlmp_unregister_link+2f/98>
   c:   89 c3                     mov    %eax,%ebx
Code;  c02b3535 <irlmp_unregister_link+31/98>
   e:   83 c4 0c                  add    $0xc,%esp
Code;  c02b3538 <irlmp_unregister_link+34/98>
  11:   85 db                     test   %ebx,%ebx
Code;  c02b353a <irlmp_unregister_link+36/98>
  13:   74 00                     je     15 <_EIP+0x15> c02b353c
<irlmp_unregister_link+38/98>

-d


--------------0CC8B5F9752F43CD50B4658F
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------0CC8B5F9752F43CD50B4658F--



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
