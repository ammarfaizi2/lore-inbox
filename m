Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290795AbSART6z>; Fri, 18 Jan 2002 14:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290796AbSART6p>; Fri, 18 Jan 2002 14:58:45 -0500
Received: from gent-smtp1.xs4all.be ([195.144.67.21]:24847 "EHLO
	gent-smtp1.xs4all.be") by vger.kernel.org with ESMTP
	id <S290795AbSART6g>; Fri, 18 Jan 2002 14:58:36 -0500
Message-ID: <3C487E68.1000404@xs4all.be>
Date: Fri, 18 Jan 2002 20:58:32 +0100
From: Didier Moens <moensd@xs4all.be>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en, nl-be
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Subject: OOPS in APM 2.4.18-pre4 with i830MP agpgart
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

On november 27th, Nicolas Aspert was so kind as to post a modification 
to agpgart, which catters for detection of the Intel i830MP.

The patch was included in 2.4.18-pre2.

Unfortunately, loading agpgart yields an oops when APM ("apm -s") is 
invoked, both in terminal and in X. APM functions perfectly when agpgart 
is absent.



The APM oops log :


Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: dde76220   ecx: 00000000   edx: 00000000
esi: 00000003   edi: 00000000   ebp: 00000000   esp: c181bf4c
ds: 0018   es: 0018   ss: 0018
Process kapm-idled (pid: 3, stackpage=c181b000)
Stack: e29d0f06 c0121e00 dde76220 00000000 00000003 dde7623c 00000064 
dde76220
        c0121eb6 dde76220 00000000 00000003 00000002 00000064 00000064 
0008e000
        c0110f0e 00000000 00000003 00000002 c0111183 00000002 c181a000 
c011131b
Call Trace: [<e29d0f06>] [<c0121e00>] [<c0121eb6>] [<c0110f0e>] [<c0111183>]
    [<c011131b>] [<c0111bfa>] [<c0140018>] [<c0105000>] [<c0105726>] 
[<c01119a0>]

Code:  Bad EIP value.
  Jan 18 10:06:01 localhost kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Jan 18 10:06:01 localhost kernel:  printing eip:
Jan 18 10:06:01 localhost kernel: 00000000
Jan 18 10:06:01 localhost kernel: *pde = 00000000
Jan 18 10:06:01 localhost kernel: Oops: 0000
Jan 18 10:06:01 localhost kernel: CPU:    0
Jan 18 10:06:01 localhost kernel: EIP:    0010:[<00000000>]    Not tainted
Jan 18 10:06:01 localhost kernel: EFLAGS: 00010246
Jan 18 10:06:01 localhost kernel: eax: 00000000   ebx: dde76220   ecx: 
00000000   edx: 00000000
Jan 18 10:06:01 localhost kernel: esi: 00000003   edi: 00000000   ebp: 
00000000   esp: c181bf4c
Jan 18 10:06:01 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jan 18 10:06:01 localhost kernel: Process kapm-idled (pid: 3, 
stackpage=c181b000)
Jan 18 10:06:01 localhost kernel: Stack: e29d0f06 c0121e00 dde76220 
00000000 00000003 dde7623c 00000064 dde76220
Jan 18 10:06:01 localhost kernel:        c0121eb6 dde76220 00000000 
00000003 00000002 00000064 00000064 0008e000
Jan 18 10:06:01 localhost kernel:        c0110f0e 00000000 00000003 
00000002 c0111183 00000002 c181a000 c011131b
Jan 18 10:06:01 localhost kernel: Call Trace: [<e29d0f06>] 
[pm_send+64/112] [pm_send_all+70/160] [send_event+30/112] 
[check_events+259/416]
Jan 18 10:06:01 localhost kernel: Call Trace: [<e29d0f06>] [<c0121e00>] 
[<c0121eb6>] [<c0110f0e>] [<c0111183>]
Jan 18 10:06:01 localhost kernel:    [apm_mainloop+123/176] 
[apm+602/624] [posix_lock_file+264/1376] [_stext+0/48] 
[kernel_thread+38/48] [apm+0/624]
Jan 18 10:06:01 localhost kernel:    [<c011131b>] [<c0111bfa>] 
[<c0140018>] [<c0105000>] [<c0105726>] [<c01119a0>]
Jan 18 10:06:01 localhost kernel:
Jan 18 10:06:01 localhost kernel: Code:  Bad EIP value.



Sincerely,


Didier Moens
-----
RUG/VIB - Dept. Molecular Biomedical Research - Core IT
tel ++32(9)2645309 fax ++32(9)2645348
http://www.dmb.rug.ac.be


