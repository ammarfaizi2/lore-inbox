Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279305AbRJZVQr>; Fri, 26 Oct 2001 17:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279277AbRJZVQg>; Fri, 26 Oct 2001 17:16:36 -0400
Received: from peabody.ximian.com ([141.154.95.10]:16644 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP
	id <S279229AbRJZVQV>; Fri, 26 Oct 2001 17:16:21 -0400
Subject: Re: Seg fault when syncing Sony Clie 760 with USB cradle
From: "Peter A. Goodall" <pete@ximian.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011025205538.A25032@kroah.com>
In-Reply-To: <1004062619.1406.29.camel@localhost.localdomain> 
	<20011025205538.A25032@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.25.15.53 (Preview Release)
Date: 26 Oct 2001 17:16:50 -0400
Message-Id: <1004131018.2425.164.camel@192.168.10-148.masq>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does the oops happen at the end of the sync, or at the beginning?
> 
> Can you run that oops through ksymoops for me?
>  

Hopefully this will help.  I'll paste output below:

ksymoops 2.4.0 on i686 2.4.12-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-xfs/ (default)
     -m /boot/System.map-2.4.12-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol
__start___kallsyms_R__ver___start___kallsyms not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__stop___kallsyms_R__ver___stop___kallsyms not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
create_bounce_R__ver_create_bounce not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
highmem_start_page_R__ver_highmem_start_page not found in System.map. 
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
kallsyms_address_to_symbol_R__ver_kallsyms_address_to_symbol not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
kallsyms_symbol_to_address_R__ver_kallsyms_symbol_to_address not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol kmap_high_R__ver_kmap_high not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol kunmap_high_R__ver_kunmap_high
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c021b700, System.map says c0151640.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore
says c8854080, /lib/modules/2.4.12-xfs/kernel/drivers/usb/usbcore.o says
c8853b40.  Ignoring /lib/modules/2.4.12-xfs/kernel/drivers/usb/usbcore.o
entry
Oct 26 11:42:45 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000014
Oct 26 11:42:45 localhost kernel: c88c6103
Oct 26 11:42:45 localhost kernel: *pde = 00000000
Oct 26 11:42:45 localhost kernel: Oops: 0002
Oct 26 11:42:45 localhost kernel: CPU:    0
Oct 26 11:42:45 localhost kernel: EIP:   
0010:[fat:__insmod_fat_S.bss_L2264+389699/11025069]    Not tainted
Oct 26 11:42:45 localhost kernel: EIP:    0010:[<c88c6103>]    Not
tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 26 11:42:45 localhost kernel: EFLAGS: 00210202
Oct 26 11:42:45 localhost kernel: eax: c658fc00   ebx: c6fa1094   ecx:
c6fa10f0   edx: 00000000
Oct 26 11:42:45 localhost kernel: esi: c6fa1000   edi: 00000000   ebp:
c2f57edc   esp: c2f57ea4
Oct 26 11:42:45 localhost kernel: ds: 0018   es: 0018   ss: 0018
Oct 26 11:42:45 localhost kernel: Process coldsync (pid: 1092,
stackpage=c2f5700
Oct 26 11:42:45 localhost kernel: Stack: c53b9000 c45953a0 0000bc01
c88c03f4 c6fa1094 c45953a0 c53b9000 00000000 
Oct 26 11:42:45 localhost kernel:        c01cf995 c53b9000 c45953a0
c019e29b c421fa30 00000002 c53b9000 c01b579f 
Oct 26 11:42:45 localhost kernel:        c421f9a4 00000008 c421f9a4
00000180 00000000 c421f9a4 00000008 c2e99240 
Oct 26 11:42:45 localhost kernel: Call Trace:
[fat:__insmod_fat_S.bss_L2264+365876/11048892] [tty_open+565/960]
[xfs_iunlock+75/128] [xfs_access+47/64] [linvfs_permission+33/48] 
Oct 26 11:42:45 localhost kernel: Call Trace: [<c88c03f4>] [<c01cf995>]
[<c019e29b>] [<c01b579f>] [<c01c0051>] 
Oct 26 11:42:45 localhost kernel:    [<c013bcbd>] [<c0133e26>]
[<c0132e76>] [<c0132d7d>] [<c013bb3e>] [<c01330a4>] 
Oct 26 11:42:45 localhost kernel:    [<c0106f0b>] 
Oct 26 11:42:45 localhost kernel: Code: 89 42 14 8b 4e 04 0f b6 53 24 8b
01 c1 e2 0f c1 e0 08 09 d0 

>>EIP; c88c6103 <[xircom_cb]trigger_transmit+3/20>   <=====
Trace; c88c03f4 <[ide-cd].data.end+2d35/7941>
Trace; c01cf995 <tty_open+235/3c0>
Trace; c019e29b <xfs_iunlock+4b/80>
Trace; c01b579f <xfs_access+2f/40>
Trace; c01c0051 <linvfs_permission+21/30>
Trace; c013bcbd <permission+1d/30>
Trace; c0133e26 <chrdev_open+36/40>
Trace; c0132e76 <dentry_open+e6/190>
Trace; c0132d7d <filp_open+4d/60>
Trace; c013bb3e <getname+5e/a0>
Trace; c01330a4 <sys_open+34/90>
Trace; c0106f0b <system_call+33/38>
Code;  c88c6103 <[xircom_cb]trigger_transmit+3/20>
00000000 <_EIP>:
Code;  c88c6103 <[xircom_cb]trigger_transmit+3/20>   <=====
   0:   89 42 14                  mov    %eax,0x14(%edx)   <=====
Code;  c88c6106 <[xircom_cb]trigger_transmit+6/20>
   3:   8b 4e 04                  mov    0x4(%esi),%ecx
Code;  c88c6109 <[xircom_cb]trigger_transmit+9/20>
   6:   0f b6 53 24               movzbl 0x24(%ebx),%edx
Code;  c88c610d <[xircom_cb]trigger_transmit+d/20>
   a:   8b 01                     mov    (%ecx),%eax
Code;  c88c610f <[xircom_cb]trigger_transmit+f/20>
   c:   c1 e2 0f                  shl    $0xf,%edx
Code;  c88c6112 <[xircom_cb]trigger_transmit+12/20>
   f:   c1 e0 08                  shl    $0x8,%eax
Code;  c88c6115 <[xircom_cb]trigger_transmit+15/20>
  12:   09 d0                     or     %edx,%eax


11 warnings issued.  Results may not be reliable.


-- 
Pete Goodall
  Support Tech
  Ximian, Inc.
  pete@ximian.com

