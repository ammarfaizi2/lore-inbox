Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130168AbRBMIBU>; Tue, 13 Feb 2001 03:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130707AbRBMIBL>; Tue, 13 Feb 2001 03:01:11 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:14864 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S129850AbRBMIAi>; Tue, 13 Feb 2001 03:00:38 -0500
Message-ID: <B45465FD9C23D21193E90000F8D0F3DF683933@mailsrv.linkvest.ch>
From: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: NFSD die with 2.4.1 
Date: Tue, 13 Feb 2001 09:00:13 +0100
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

The Oops: (repeated 8 times in the logs)
Feb  8 10:20:42 fatboy kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Feb  8 10:20:42 fatboy kernel:  printing eip:
Feb  8 10:20:42 fatboy kernel: 00000000
Feb  8 10:20:42 fatboy kernel: *pde = 00000000
Feb  8 10:20:42 fatboy kernel: Oops: 0000
Feb  8 10:20:42 fatboy kernel: CPU:    0
Feb  8 10:20:42 fatboy kernel: EIP:    0010:[acpi_exit+0/-1072693248]
Feb  8 10:20:42 fatboy kernel: EFLAGS: 00010282
Feb  8 10:20:42 fatboy kernel: eax: 00000000   ebx: c4fa803c   ecx: c29cc660
edx: c88a5450
Feb  8 10:20:42 fatboy kernel: esi: c5002ce4   edi: c4fa803c   ebp: c4fa803c
esp: c4fa7f38
Feb  8 10:20:42 fatboy kernel: ds: 0018   es: 0018   ss: 0018
Feb  8 10:20:42 fatboy kernel: Process nfsd (pid: 2690, stackpage=c4fa7000)
Feb  8 10:20:42 fatboy kernel: Stack: c88a54b4 c29cc660 00008000 c4fad000
c88a8ba0 c4fa8014 c4fad000 c29cc660
Feb  8 10:20:42 fatboy kernel:        a1ff8014 c889e5bb c4fad000 c4fa801c
c5002cc0 c4fad138 c88a8ba0 c5002d14
Feb  8 10:20:42 fatboy kernel:        c8888f08 c4fad000 c4fa8014 c4fa6000
003dea49 c7f69ca0 c4fa6550 c5002cc0
Feb  8 10:20:42 fatboy kernel: Call Trace: [<c88a54b4>] [<c88a8ba0>]
[<c889e5bb>] [<c88a8ba0>] [<c8888f08>] [<c88a8f20>] [<c88a8a88>]
Feb  8 10:20:42 fatboy kernel:        [<c889e331>] [kernel_thread+35/48]
Feb  8 10:20:42 fatboy kernel:
Feb  8 10:20:42 fatboy kernel: Code:  Bad EIP value.



_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
http://www.linkvest.com  E-mail: jean-eric.cuendet@linkvest.com
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 



