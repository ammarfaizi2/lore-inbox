Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131338AbQLIOz2>; Sat, 9 Dec 2000 09:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131506AbQLIOzT>; Sat, 9 Dec 2000 09:55:19 -0500
Received: from pop.gmx.net ([194.221.183.20]:14546 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S131338AbQLIOzC>;
	Sat, 9 Dec 2000 09:55:02 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
Date: Sat, 9 Dec 2000 15:22:22 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10012090259360.13311-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10012090259360.13311-100000@coffee.psychology.mcmaster.ca>
Subject: Re: kernel bug with 2.4.0-test12pre7 at startup
MIME-Version: 1.0
Message-Id: <00120914215500.01817@nmb>
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

after applying that patch I cut out of an email from Linus the bug continues 
to appear but the output of ksymoops looks a little bit shorter.

>I've read Linus' posting and patched my kernel. It's compiling now. 
>Nevertheless I attached the output of ksymoops - maybe it'll be still 
>helpfull - or throw it away.

kind regards
Norbert

============== new output of ksymoops after Linus'  patch==================
ksymoops 0.7c on i586 2.4.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11/ (default)
     -m /boot/System.map (specified)

<4>invalid operand: 0000
<4>CPU:    0
<4>EIP:    0010:[end_buffer_io_async+238/304]
<4>EFLAGS: 00010286
<4>eax: 0000001c   ebx: c7e78d40   ecx: c0265e88   edx: c0265e88
<4>esi: c1219768   edi: 00000202   ebp: c7e78d88   esp: c7ea1bd8
<4>ds: 0018   es: 0018   ss: 0018
<4>Process swapper (pid: 7, stackpage=c7ea1000)
<4>Stack: c0223ea5 c02241da 0000033b c12b1780 c1296c00 c7e76800 c7e78d40 
c016e07
<4>       c7e78d40 00000001 c7e78d40 00000001 00000004 0000002c c016687c 
c02d9ea
<4>       00000000 c7e78d40 c7e78d40 00000001 00000000 c7ea1c84 c01669f3 
0000000
<4>Call Trace: [tvecs+13789/69284] [tvecs+14610/69284] 
[rd_make_request+249/260]
<4>Code: 0f 0b 83 c4 0c 90 8d 74 26 00 8d 5e 28 8d 46 2c 39 46 2c 74 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   90                        nop    
Code;  00000006 Before first symbol
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000a Before first symbol
   a:   8d 5e 28                  lea    0x28(%esi),%ebx
Code;  0000000d Before first symbol
   d:   8d 46 2c                  lea    0x2c(%esi),%eax
Code;  00000010 Before first symbol
  10:   39 46 2c                  cmp    %eax,0x2c(%esi)
Code;  00000013 Before first symbol
  13:   74 00                     je     15 <_EIP+0x15> 00000015 Before first 
symbol



======================================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
