Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271118AbRHOJgj>; Wed, 15 Aug 2001 05:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271119AbRHOJgb>; Wed, 15 Aug 2001 05:36:31 -0400
Received: from ltspc67.epfl.ch ([128.178.121.34]:13696 "EHLO ltspc67.epfl.ch")
	by vger.kernel.org with ESMTP id <S271118AbRHOJgJ>;
	Wed, 15 Aug 2001 05:36:09 -0400
Message-ID: <3B7A428D.21E9EAC2@epfl.ch>
Date: Wed, 15 Aug 2001 11:36:13 +0200
From: Diego Santa Cruz <Diego.SantaCruz@epfl.ch>
Organization: Ecole Polytechnique Federale de Lausanne
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, es, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS in 2.4.3-12 and 2.4.8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have experienced an OOPS while unloading the cdrom module. My system is an HP Omnibook 4150
laptop. I booted the standard 2.4.3-12 kernel of RedHat 7.1 without having the CDROM drive inserted.
If I load the cdrom and ide-cd modules (which are sometimes automatically loaded) and then unload
them I get an OOPS right after unloading cdrom. The bug is reproducible. I have also tried 2.4.8
(official kernel this time) and the problem also occurs (I can check for sure where and provide
ksymoops output if necessary).

Kernel command line: auto BOOT_IMAGE=rh-7.1 ro root=301 BOOT_FILE=/boot/vmlinuz-2.4.3-12

The oops analysis by ksymoops on kernel 2.4.3-12 gives:

ksymoops 2.4.0 on i686 2.4.3-12.  Options used
     -v /boot/vmlinux-2.4.3-12 (specified)
     -k /home/sun1/dsanta/ksyms (specified)
     -l /home/sun1/dsanta/modules (specified)
     -o /lib/modules/2.4.3-12/ (specified)
     -m /boot/System.map-2.4.3-12 (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01af700, vmlinux says
c0151680.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol proc_irda  , irda says d09358fc,
/lib/modules/2.4.3-12/kernel/net/irda/irda.o says d0934f3c.  Ignoring
/lib/modules/2.4.3-12/kernel/net/irda/irda.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd says d08f7994,
/lib/modules/2.4.3-12/kernel/fs/lockd/lockd.o says d08f6e00.  Ignoring
/lib/modules/2.4.3-12/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says d08f7990,
/lib/modules/2.4.3-12/kernel/fs/lockd/lockd.o says d08f6dfc.  Ignoring
/lib/modules/2.4.3-12/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says d08f7998,
/lib/modules/2.4.3-12/kernel/fs/lockd/lockd.o says d08f6e04.  Ignoring
/lib/modules/2.4.3-12/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says d08c7120,
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o says d08c6de0.  Ignoring
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says d08c7124,
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o says d08c6de4.  Ignoring
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says d08c7128,
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o says d08c6de8.  Ignoring
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says d08c711c,
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o says d08c6ddc.  Ignoring
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_garbage_args  , sunrpc says d08c70fc,
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o says d08c6dbc.  Ignoring
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_success  , sunrpc says d08c70ec,
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o says d08c6dac.  Ignoring
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_system_err  , sunrpc says d08c7100,
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o says d08c6dc0.  Ignoring
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_one  , sunrpc says d08c70e4,
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o says d08c6da4.  Ignoring
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_two  , sunrpc says d08c70e8,
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o says d08c6da8.  Ignoring
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_zero  , sunrpc says d08c70e0,
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o says d08c6da0.  Ignoring
/lib/modules/2.4.3-12/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d084dc80,
/lib/modules/2.4.3-12/kernel/drivers/usb/usbcore.o says d084d7a0.  Ignoring
/lib/modules/2.4.3-12/kernel/drivers/usb/usbcore.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000008
c011a345
Oops: 0000
CPU:    0
EIP:    0010:[<c011a345>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210246
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c19cd000   edi: 00000000   ebp: 00000000   esp: cbf63f7c
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 2171, stackpage=cbf63000)
Stack: d08aa000 d08ae5bb 00000000 d08ae5fa 00000000 d08b0240 c011792e d08aa000 
       c19cd000 00000000 c0116e19 d08aa000 00000000 cbf62000 bffff6b5 00000001 
       bfffe458 c0106d2b bffff6b5 0805f168 00000131 bffff6b5 00000001 bfffe458 
Call Trace: [<d08aa000>] [<d08ae5bb>] [<d08ae5fa>] [<d08b0240>] [<c011792e>] 
   [<d08aa000>] [<c0116e19>] [<d08aa000>] [<c0106d2b>] 
Code: 8b 53 08 8b 43 04 89 50 04 89 02 8b 0d 94 5c 2a c0 51 8b 13 

>>EIP; c011a345 <unregister_sysctl_table+5/30>   <=====
Trace; d08aa000 <[serial_cs].data.end+4021/4081>
Trace; d08ae5bb <[cdrom]cdrom_sysctl_unregister+b/10>
Trace; d08ae5fa <[cdrom]cdrom_exit+1a/1f>
Trace; d08b0240 <[cdrom].rodata.start+1a20/1a5f>
Trace; c011792e <free_module+1e/d0>
Trace; d08aa000 <[serial_cs].data.end+4021/4081>
Trace; c0116e19 <sys_delete_module+109/1e0>
Trace; d08aa000 <[serial_cs].data.end+4021/4081>
Trace; c0106d2b <system_call+33/38>
Code;  c011a345 <unregister_sysctl_table+5/30>
00000000 <_EIP>:
Code;  c011a345 <unregister_sysctl_table+5/30>   <=====
   0:   8b 53 08                  mov    0x8(%ebx),%edx   <=====
Code;  c011a348 <unregister_sysctl_table+8/30>
   3:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c011a34b <unregister_sysctl_table+b/30>
   6:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c011a34e <unregister_sysctl_table+e/30>
   9:   89 02                     mov    %eax,(%edx)
Code;  c011a350 <unregister_sysctl_table+10/30>
   b:   8b 0d 94 5c 2a c0         mov    0xc02a5c94,%ecx
Code;  c011a356 <unregister_sysctl_table+16/30>
  11:   51                        push   %ecx
Code;  c011a357 <unregister_sysctl_table+17/30>
  12:   8b 13                     mov    (%ebx),%edx


16 warnings issued.  Results may not be reliable.

-- 
-----------------------------------------------------------------------
Diego Santa Cruz                         mailto:Diego.Santacruz@epfl.ch
Signal Processing Laboratory (LTS)        http://ltswww.epfl.ch/~dsanta
Swiss Federal Institute of Technology (EPFL)
EL - Ecublens - CH-1015 Lausanne - Switzerland
Office:     ELE 236
Phone:      +41 - 21 - 693 26 57 (Office)
            +41 - 21 - 693 46 20 (LTS Lab)                 *   *
Fax:        +41 - 21 - 693 76 00                           'O^-'
Mobile:     +41 - 79 - 419 56 71                           ( o )
-------------------------------------------------------- oOO U OOo ----
