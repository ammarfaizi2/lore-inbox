Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280816AbRKLPJw>; Mon, 12 Nov 2001 10:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280818AbRKLPJm>; Mon, 12 Nov 2001 10:09:42 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:23494 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S280816AbRKLPJh>; Mon, 12 Nov 2001 10:09:37 -0500
Message-ID: <3BEFE601.4050808@korseby.net>
Date: Mon, 12 Nov 2001 16:08:49 +0100
From: Kristian <kristian@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.15pre1-Oops with netfilter
Content-Type: multipart/mixed;
 boundary="------------080101070003010003020400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080101070003010003020400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello.

This nice oops is repeatable. After successfully connecting (via ISDN) to the 
internet I'm getting this oops when I'm trying to transfer something.
I'm currently using iptables-1.2.4 & 2.4.15pre1 if it's relevant.

If you need additional info just let me know.

*Kristian

-- 
·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                          :: http://www.korseby.net
                          :: http://www.tomlab.de
kristian@korseby.net ....::

--------------080101070003010003020400
Content-Type: text/plain;
 name="icewall-ksymoopsed"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="icewall-ksymoopsed"

ksymoops 2.4.3 on i586 2.4.15-pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre1/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 000003c6
c01c205c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01c205c>]   Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 000005dc   ebx: c4c1f780   ecx: c4042010 edx: 00000000
esi: c4c269f4   edi: 00000000   ebp: c4516500 esp: c39a5d68
ds: 0018   es: 0018   ss: 0018
Process wget (pid: 2652, stackpage=c39a5000)
Stack: 00000001 00000003 00000000 c4042010 c4042010 c01b8ebf c4c1f780 c4c2b2f4
       c4d18138 c4c1fbe0 c4c26308 c028f5b8 c01c10c9 00000002 00000003 c4c1f780
       00000000 c4042010 00000002 c01c1fbc e4d18138 00000028 c4c26308 c022b280
Call Trace: [<c01b8ebf>] [<c01c10c9>] [<c01c1fbc>] [<c01d39c7>] [<c01ceeaf>]
   [<c01cef49>] [<c01d118d>] [<c01d3259>] [<c01ddc78>] [<c01adc87>] [<c01ace76>]
   [<c013d4d6>] [<c01ae5be>] [<c010beb4>] [<c0106da3>]
Code: 8a 87 c6 02 00 00 3c 02 74 0a 3c 01 75 0b f6 45 20 04 75 05

>>EIP; c01c205c <ip_queue_xmit2+a0/224>   <=====
Trace; c01b8ebe <nf_hook_slow+13a/188>
Trace; c01c10c8 <ip_queue_xmit+288/2e4>
Trace; c01c1fbc <ip_queue_xmit2+0/224>
Trace; c01d39c6 <tcp_v4_send_check+6e/ac>
Trace; c01ceeae <tcp_transmit_skb+476/5cc>
Trace; c01cef48 <tcp_transmit_skb+510/5cc>
Trace; c01d118c <tcp_connect+3d8/4f8>
Trace; c01d3258 <tcp_v4_connect+2f8/334>
Trace; c01ddc78 <inet_stream_connect+138/2a8>
Trace; c01adc86 <sys_connect+5a/78>
Trace; c01ace76 <sock_map_fd+10e/184>
Trace; c013d4d6 <dput+106/124>
Trace; c01ae5be <sys_socketcall+86/1dc>
Trace; c010beb4 <get_fpregs+bc/1a8>
Trace; c0106da2 <system_call+32/40>
Code;  c01c205c <ip_queue_xmit2+a0/224>
00000000 <_EIP>:
Code;  c01c205c <ip_queue_xmit2+a0/224>   <=====
   0:   8a 87 c6 02 00 00         mov    0x2c6(%edi),%al   <=====
Code;  c01c2062 <ip_queue_xmit2+a6/224>
   6:   3c 02                     cmp    $0x2,%al
Code;  c01c2064 <ip_queue_xmit2+a8/224>
   8:   74 0a                     je     14 <_EIP+0x14> c01c2070 <ip_queue_xmit2+b4/224>
Code;  c01c2066 <ip_queue_xmit2+aa/224>
   a:   3c 01                     cmp    $0x1,%al
Code;  c01c2068 <ip_queue_xmit2+ac/224>
   c:   75 0b                     jne    19 <_EIP+0x19> c01c2074 <ip_queue_xmit2+b8/224>
Code;  c01c206a <ip_queue_xmit2+ae/224>
   e:   f6 45 20 04               testb  $0x4,0x20(%ebp)
Code;  c01c206e <ip_queue_xmit2+b2/224>
  12:   75 05                     jne    19 <_EIP+0x19> c01c2074 <ip_queue_xmit2+b8/224>

 <0> Kernel panic: Aiee, killing interrupt handler!

--------------080101070003010003020400--

