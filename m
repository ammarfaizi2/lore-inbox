Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131721AbRBMO7c>; Tue, 13 Feb 2001 09:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131725AbRBMO7X>; Tue, 13 Feb 2001 09:59:23 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:27151 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S131721AbRBMO7G>; Tue, 13 Feb 2001 09:59:06 -0500
Message-ID: <B45465FD9C23D21193E90000F8D0F3DF683943@mailsrv.linkvest.ch>
From: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: NFSD die with 2.4.1 (resend with ksymoops)
Date: Tue, 13 Feb 2001 15:58:50 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
I have a machine with kernel 2.4.1 . It exports some volume via NFS
(installed with RedHat 7.0 + custom 2.4.1 kernel)
NFSD dies unexpectedly with a Oops (see below).
At the beginning, I have 8 NFSD processes, but suddenly, they all die. I
can't see why it happens, because the machine is a production one and I
can't reboot it too often. But when I reboot, all is fine for a moment. And
suddenly, the 8 NFSD die altogether...
When running lsmod, nfsd.o has 8 locks even after NFSD died, so it's
impossible to make a rmmod (the 8 NFSD processes don't give their ressources
back).
Anyone have similar problems?
Thanks for any help on that topic

Bye
-jec
PS: I'm not in the list, so CC please.

ksymoops 2.4.0 on i686 2.4.1-acls0.7.5-3.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-acls0.7.5-3/ (default)
     -m /boot/System.map-2.4.1-acls0.7.5-3 (specified)
 
Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[acpi_exit+0/-1072693248]
EFLAGS: 00010286
eax: c02dbc60   ebx: c5f84600   ecx: 00000000   edx: c5e2c03c
esi: c5f84224   edi: c5e2c03c   ebp: c4ad7220   esp: c5dcdf24
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 542, stackpage=c5dcd000)
Stack: c889300d c4ad7220 00008000 c5e2c03c c5f84400 c5f84600 c888bd7e
c5f84400
       a1ff4600 c5f84400 c526b794 0000000b c5f84600 c889b3e0 c5e2c014
c5f84600
       c888b5ea c5f84600 c5e2c01c c5f84200 c5f84738 c889b3e0 c5f84290
c8872883
Call Trace: [<c889300d>] [<c888bd7e>] [<c889b3e0>] [<c888b5ea>] [<c889b3e0>]
[<c8872883>] [<c889b2c8>]
       [<c889b2f8>] [<c888b3b9>] [<c889b2c0>] [kernel_thread+38/48]
[<c888b190>]
Code:  Bad EIP value.
Using defaults from ksymoops -t elf32-i386 -a i386
 
Trace; c889300d <[sunrpc].bss.end+1a16/1a69>
Trace; c888bd7e <[sunrpc].rodata.start+33e/400e>
Trace; c889b3e0 <[lockd].rodata.start+2ca0/30ff>
Trace; c888b5ea <[sunrpc]svc_proc_read+de/148>
Trace; c889b3e0 <[lockd].rodata.start+2ca0/30ff>
Trace; c8872883 <_end+8529c53/8533430>
Trace; c889b2c8 <[lockd].rodata.start+2b88/30ff>
Trace; c889b2f8 <[lockd].rodata.start+2bb8/30ff>
Trace; c888b3b9 <[sunrpc]xdr_zero_iovec+7d/94>
Trace; c889b2c0 <[lockd].rodata.start+2b80/30ff>



_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
http://www.linkvest.com  E-mail: jean-eric.cuendet@linkvest.com
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 



