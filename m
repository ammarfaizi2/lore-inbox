Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSGALcH>; Mon, 1 Jul 2002 07:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSGALcG>; Mon, 1 Jul 2002 07:32:06 -0400
Received: from [194.67.156.125] ([194.67.156.125]:2196 "EHLO mail.cboss.ru")
	by vger.kernel.org with ESMTP id <S315479AbSGALb6>;
	Mon, 1 Jul 2002 07:31:58 -0400
Message-ID: <3D203E6B.4010300@cboss.ru>
Date: Mon, 01 Jul 2002 15:35:07 +0400
From: "Nicholas L. Nigay" <nnigay@cboss.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: oops 2.4.19-rc1 process lockd ( part 3 : no vmware )]
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Archived: msg.XXq1ViJa@mail
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops occures after 'showmount -e <linux_ip>' command has been executed.

ksymoops 2.4.5 on i686 2.4.19-rc1.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.19-rc1/ (default)
      -m /boot/System.map (specified)

Unable to handle kernel paging request at virtual address 8b80c058
c02ac415
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c02ac415>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: 300c9800   ebx: cb4e6058   ecx: cb4e6058   edx: cc99be64
esi: cc99be6c   edi: c0186fc8   ebp: cc400900   esp: cd319d94
ds: 0018   es: 0018   ss: 0018
Process lockd (pid: 90, stackpage=cd319000)
Stack: cb4e6058 cc99be6c c0186fc8 c0186719 cb4e6058 cc99be64 cd39205c 
cd4ed880
        c0186fc8 cc400900 cd4ed880 cb4e6018 00000000 cc400900 c0186fdc 
cb4e6044
        cc99be08 cd39205c c02a47fc cd39205c cb4e6044 cc99be08 cd4ed8d4 
fffffff5
Call Trace: [<c0186fc8>] [<c0186719>] [<c0186fc8>] [<c0186fdc>] 
[<c02a47fc>]
    [<c02a79ac>] [<c02a4496>] [<c02a7c17>] [<c02a4431>] [<c018168a>] 
[<c0187a0c>]
    [<c01879e7>] [<c0187a0c>] [<c01874e8>] [<c026a316>] [<c0237065>] 
[<c0186417>]
    [<c018647c>] [<c018649a>] [<c018691a>] [<c02a9d81>] [<c018278e>] 
[<c0107028>]
Code: c7 04 83 00 00 00 00 8b 02 0f c8 89 01 8b 72 04 8b 02 83 c3


 >>EIP; c02ac415 <xdr_encode_netobj+15/4c>   <=====

 >>eax; 300c9800 Before first symbol
 >>ebx; cb4e6058 <_end+b13cd48/1047fcf0>
 >>ecx; cb4e6058 <_end+b13cd48/1047fcf0>
 >>edx; cc99be64 <_end+c5f2b54/1047fcf0>
 >>esi; cc99be6c <_end+c5f2b5c/1047fcf0>
 >>edi; c0186fc8 <nlm4clt_encode_testres+0/30>
 >>ebp; cc400900 <_end+c0575f0/1047fcf0>
 >>esp; cd319d94 <_end+cf70a84/1047fcf0>

Trace; c0186fc8 <nlm4clt_encode_testres+0/30>
Trace; c0186719 <nlm4_encode_testres+89/1f0>
Trace; c0186fc8 <nlm4clt_encode_testres+0/30>
Trace; c0186fdc <nlm4clt_encode_testres+14/30>
Trace; c02a47fc <call_encode+d8/104>
Trace; c02a79ac <__rpc_execute+a8/2bc>
Trace; c02a4496 <rpc_call_setup+3e/70>
Trace; c02a7c17 <rpc_execute+57/70>
Trace; c02a4431 <rpc_call_async+7d/a4>
Trace; c018168a <nlmsvc_async_call+82/98>
Trace; c0187a0c <nlm4svc_callback_exit+0/54>
Trace; c01879e7 <nlm4svc_callback+73/98>
Trace; c0187a0c <nlm4svc_callback_exit+0/54>
Trace; c01874e8 <nlm4svc_proc_test_msg+48/54>
Trace; c026a316 <inet_sendmsg+3a/40>
Trace; c0237065 <sock_sendmsg+69/88>
Trace; c0186417 <nlm4_decode_oh+f/14>
Trace; c018647c <nlm4_decode_lock+4c/130>
Trace; c018649a <nlm4_decode_lock+6a/130>
Trace; c018691a <nlm4svc_decode_testargs+4e/54>
Trace; c02a9d81 <svc_process+219/4d8>
Trace; c018278e <lockd+19a/254>
Trace; c0107028 <kernel_thread+28/38>

Code;  c02ac415 <xdr_encode_netobj+15/4c>
0000000000000000 <_EIP>:
Code;  c02ac415 <xdr_encode_netobj+15/4c>   <=====
    0:   c7 04 83 00 00 00 00      movl   $0x0,(%ebx,%eax,4)   <=====
Code;  c02ac41c <xdr_encode_netobj+1c/4c>
    7:   8b 02                     mov    (%edx),%eax
Code;  c02ac41e <xdr_encode_netobj+1e/4c>
    9:   0f c8                     bswap  %eax
Code;  c02ac420 <xdr_encode_netobj+20/4c>
    b:   89 01                     mov    %eax,(%ecx)
Code;  c02ac422 <xdr_encode_netobj+22/4c>
    d:   8b 72 04                  mov    0x4(%edx),%esi
Code;  c02ac425 <xdr_encode_netobj+25/4c>
   10:   8b 02                     mov    (%edx),%eax
Code;  c02ac427 <xdr_encode_netobj+27/4c>
   12:   83 c3 00                  add    $0x0,%ebx

-- 
Good luck!
Nicholas L. Nigay


