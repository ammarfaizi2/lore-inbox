Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269794AbRHDEq4>; Sat, 4 Aug 2001 00:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269796AbRHDEqq>; Sat, 4 Aug 2001 00:46:46 -0400
Received: from wolf.ericsson.net.nz ([203.97.68.250]:12440 "EHLO
	wolf.ericsson.net.nz") by vger.kernel.org with ESMTP
	id <S269794AbRHDEqe>; Sat, 4 Aug 2001 00:46:34 -0400
Date: Sat, 4 Aug 2001 16:46:40 +1200 (NZST)
From: <kern@wolf.ericsson.net.nz>
To: <linux-kernel@vger.kernel.org>
Subject: Oops pcnet32 ethernet driver on Compaq Deskpro 5100
Message-ID: <Pine.LNX.4.33.0108041641480.14017-100000@wolf.ericsson.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey -

I am getting the following oops when I try to insert the pcnet32 ethernet
driver on an older Compaq 5100 (Pentium 100 with onboard ethernet
controller) and rh7.1

When the machine boots the module loads Ok, I only get this error when I
rmmod pcnet32 and then modprobe to reinsert it.

The ethernet card will not work - ifconfig will not show it although
ifconfig eth0 will show the interface.

any pointers about how I might get this onboard interface to work or am I
better advised to buy a pci ethernet card?

cheers
Mark


[root@pup /etc]# modprobe pcnet32
Note: /etc/modules.conf is more recent than /lib/modules/2.4.2-2/modules.dep
Unable to handle kernel paging request at virtual address c3833e20
 printing eip:
c019ee7d
pgd entry c1702c38: 00000000010ee063
pmd entry c1702c38: 00000000010ee063
pte entry c10ee0cc: 0000000000000000
... pte not present!
Oops: 0002
CPU:    0
EIP:    0010:[<c019ee7d>]
EFLAGS: 00010246
eax: c3833e20   ebx: c3824000   ecx: 00000040   edx: c0258164
esi: c3826e20   edi: 00000000   ebp: 00000060   esp: c16fff08
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 666, stackpage=c16ff000)
Stack: c3824000 00000000 00000000 c3826124 c3826e20 c3824000 00000000 00000000
       00000060 c0116ff7 00000000 c1662000 00002e60 c1663000 00000060 ffffffea
       00000007 c232c800 00000060 c0256ce0 c3824060 00002fd0 00000000 00000000
Call Trace: [<c3824000>] [<c3826124>] [<c3826e20>] [<c3824000>] [<c0116ff7>] [<c3824060>] [<c0108fb3>]

Code: 89 30 8b 1d c8 60 26 c0 81 fb c8 60 26 c0 74 23 8d 76 00 53
Segmentation fault
pcnet32                12240   1  (initializing)


