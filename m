Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263393AbRFAPOH>; Fri, 1 Jun 2001 11:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263292AbRFAPOA>; Fri, 1 Jun 2001 11:14:00 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:64903 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S263397AbRFAPNn>; Fri, 1 Jun 2001 11:13:43 -0400
Date: Fri, 1 Jun 2001 16:13:40 +0100
From: David Harris <linux@davidharris.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Kernel oops
Message-ID: <20010601161340.A18270@cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(many apologies for repost - i'll actually attach the attachment this
time)

I am running gnome netleds_applet version 0.9.1 and it is sporadically
dieing, with a various kernel oops warnings in my syslogs. I caught
the last one and ran it through ksymoops - I've attached the output of
that. It happens every few days and doesn't seem to be caused by
anything specific that I can see. Always the same program, and the
overall stability of the system seems unaffected. If it makes any
difference I have two copies of netleds running (they monitor eth0
and ppp0 separately). The processor is a Cyric 6x86MX233. Any other
information you'd find useful, please contact me!

yours

David Harris

-- 
     David Harris, 10 Carlton Way,     |  My name is Inigo Montoya.
  Cambridge CB4 2BZ Tel: 01223 524413  |    You killed my father.
  Mob: 07977 226941 Fax: 07970 091596  |       Prepare to die.
    http://www.srcf.ucam.org/~djh59/   |

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oopsout.txt"

ksymoops 2.4.1 on i686 2.4.4.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.4/ (default)
     -m /boot/System.map-2.4.4 (specified)

Unable to handle kernel paging request at virtual address 856d1cfc
c013690b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013690b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: 32ae102f   ebx: 005e1a04   ecx: c2e62900   edx: 00000001
esi: 08095529   edi: 404e5ded   ebp: 005e1a04   esp: c1ebbf54
ds: 0018   es: 0018   ss: 0018
Process netleds_applet (pid: 501, stackpage=c1ebb000)
Stack: c013715a 005e1a04 00000000 08095528 404e5ded c33ba000 c012c4f7 c33ba000 
       00000001 000001b6 c1ebbf84 0000000f c33ba000 08095528 404e5ded c33ba000 
       00000000 c2e62900 00000400 c012c80c c33ba000 00000000 000001b6 c1eba000 
Call Trace: [<c013715a>] [<c012c4f7>] [<c012c80c>] [<c0106ac3>] [<c010002b>] 
Code: 00 83 f8 02 0f 85 eb 00 00 00 80 7a 01 2e 0f 85 e1 00 00 00 

>>EIP; c013690b <path_walk+437/7bc>   <=====
Trace; c013715a <open_namei+1a/5d0>
Trace; c012c4f7 <filp_open+33/54>
Trace; c012c80c <sys_open+38/b4>
Trace; c0106ac3 <system_call+33/40>
Trace; c010002b <startup_32+2b/a5>
Code;  c013690b <path_walk+437/7bc>
00000000 <_EIP>:
Code;  c013690b <path_walk+437/7bc>   <=====
   0:   00 83 f8 02 0f 85         add    %al,0x850f02f8(%ebx)   <=====
Code;  c0136911 <path_walk+43d/7bc>
   6:   eb 00                     jmp    8 <_EIP+0x8> c0136913 <path_walk+43f/7bc>
Code;  c0136913 <path_walk+43f/7bc>
   8:   00 00                     add    %al,(%eax)
Code;  c0136915 <path_walk+441/7bc>
   a:   80 7a 01 2e               cmpb   $0x2e,0x1(%edx)
Code;  c0136919 <path_walk+445/7bc>
   e:   0f 85 e1 00 00 00         jne    f5 <_EIP+0xf5> c0136a00 <path_walk+52c/7bc>


--4Ckj6UjgE2iN1+kY--
