Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLXAiZ>; Sat, 23 Dec 2000 19:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbQLXAiP>; Sat, 23 Dec 2000 19:38:15 -0500
Received: from pm3-6-30.apex.net ([209.250.41.93]:59397 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S129595AbQLXAiK>; Sat, 23 Dec 2000 19:38:10 -0500
Date: Sat, 23 Dec 2000 18:07:31 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] ppp_generic in kernel 2.4.0-test12
Message-ID: <20001223180731.A10229@hapablap.dyn.dhs.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This oops occurred while I was on the internet.  modemlights_applet, the
process that caused the oops, died, and upon being restarted, is hung in
the "D" state.  kill -9 won't even rid me of it.  The internet
connection is still alive, though, as I can ping sites.  The system is
an AMD-K6/2, the kernel 2.4.0-test12+reiserfs and a winmodem driver.
The processed oops is attached.
-- 
-Steven
"Voters decide nothing.  Vote counters decide everything."
				-Joseph Stalin

ksymoops 2.3.4 on i586 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel paging request at virtual address 810826fc
c491fd7f
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c491fd7f>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010297
eax: c20e4e00   ebx: c20e4e00   ecx: 000089f0   edx: bffffa28
esi: 000089f0   edi: 00000000   ebp: c3b99280   esp: c0bcfe5c
ds: 0018   es: 0018   ss: 0018
Process modemlights_app (pid: 3562, stackpage=c0bcf000)
Stack: c20e4e00 000089f0 00000000 c0bcff54 bffffa28 fffffff2 00000002 c3a63601 
       04000001 0000270f c113200c c113200c 00000002 00000000 00000001 00000001 
       c1a15920 c1588780 00000006 c1a15920 c344717c c0122c8e c0bcfee4 00000006 
Call Trace: [<c0122c8e>] [<c0114732>] [<c019662a>] [<c0196809>] [<c01b8407>] [<c0191372>] [<c013c6d6>] 
       [<c010a6f3>] 
Code: 81 b7 fc 26 08 81 03 ae 04 93 09 be fc 12 0a a5 fe 7b 0b 67 

>>EIP; c491fd7f <[ppp_generic]ppp_net_ioctl+3f/168>   <=====
Trace; c0122c8e <avl_remove+b2/c0>
Trace; c0114732 <send_sig_info+22/98>
Trace; c019662a <dev_ifsioc+2fe/310>
Trace; c0196809 <dev_ioctl+1cd/234>
Trace; c01b8407 <inet_ioctl+16f/178>
Trace; c0191372 <sock_ioctl+1a/20>
Trace; c013c6d6 <sys_ioctl+16a/184>
Trace; c010a6f3 <system_call+33/40>
Code;  c491fd7f <[ppp_generic]ppp_net_ioctl+3f/168>
00000000 <_EIP>:
Code;  c491fd7f <[ppp_generic]ppp_net_ioctl+3f/168>   <=====
   0:   81 b7 fc 26 08 81 03      xorl   $0x9304ae03,0x810826fc(%edi)   <=====
Code;  c491fd86 <[ppp_generic]ppp_net_ioctl+46/168>
   7:   ae 04 93 
Code;  c491fd89 <[ppp_generic]ppp_net_ioctl+49/168>
   a:   09 be fc 12 0a a5         or     %edi,0xa50a12fc(%esi)
Code;  c491fd8f <[ppp_generic]ppp_net_ioctl+4f/168>
  10:   fe                        (bad)  
Code;  c491fd90 <[ppp_generic]ppp_net_ioctl+50/168>
  11:   7b 0b                     jnp    1e <_EIP+0x1e> c491fd9d <[ppp_generic]ppp_net_ioctl+5d/168>
Code;  c491fd92 <[ppp_generic]ppp_net_ioctl+52/168>
  13:   67 00 00                  addr16 add %al,(%bx,%si)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
