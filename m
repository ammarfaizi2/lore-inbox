Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTIGPk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 11:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTIGPk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 11:40:27 -0400
Received: from tank.questzones.com ([207.253.48.35]:3087 "EHLO
	tank2.questzones.com") by vger.kernel.org with ESMTP
	id S263319AbTIGPkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 11:40:23 -0400
Message-ID: <00ce01c3754e$64de8770$8000a8c0@elbasta>
From: "Frederic Trudeau" <ftrudeau@zesolution.com>
To: "Frederic Trudeau" <ftrudeau@zesolution.com>,
       <linux-kernel@vger.kernel.org>
References: <004301c37491$12c97b60$8000a8c0@elbasta>
Subject: Re: kernel oops with kernel-smp-2.4.20-20.9 (Unable to handle kernel NULL pointer dereference at virtual address 00000000)
Date: Sun, 7 Sep 2003 10:43:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Should I post this message to another list in order to get help ?

----- Original Message ----- 
From: "Frederic Trudeau" <ftrudeau@zesolution.com>
To: <linux-kernel@vger.kernel.org>
Sent: Saturday, September 06, 2003 12:08 PM
Subject: kernel oops with kernel-smp-2.4.20-20.9 (Unable to handle kernel
NULL pointer dereference at virtual address 00000000)


> Greetings all.
>
> Im getting the error message "Unable to handle kernel NULL pointer
> dereference at virtual address 00000000" when trying to load (ifup eth1)
> eth1 with kernel-smp-2.4.20-20.9. It works fine with non-smp package from
> RH.
>
> Now im not sure if im using the ksymoops tool correctly, as im getting
error
> using it ...
> but heres the output anyway :
>
> [root@localhost oops]# ksymoops -v /boot/vmlinux-2.4.20-20.9smp -k
> /root/oops/ksyms -l /root/oops/modules < oops.txt
> ksymoops 2.4.5 on i686 2.4.20-20.9smp.  Options used
>      -v /boot/vmlinux-2.4.20-20.9smp (specified)
>      -k /root/oops/ksyms (specified)
>      -l /root/oops/modules (specified)
>      -o /lib/modules/2.4.20-20.9smp/ (default)
>      -m /boot/System.map-2.4.20-20.9smp (default)
>
> Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
> ksymoops: No such file or directory
> Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
> ksymoops: No such file or directory
> Error (expand_objects): cannot stat(/lib/aacraid.o) for aacraid
> ksymoops: No such file or directory
> Error (expand_objects): cannot stat(/lib/aic79xx.o) for aic79xx
> ksymoops: No such file or directory
> Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
> ksymoops: No such file or directory
> Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
> ksymoops: No such file or directory
> Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique
> module object.  Trace may not be reliable.
> Warning (map_ksym_to_module): cannot match loaded module aacraid to a
unique
> module object.  Trace may not be reliable.
> Sep  6 11:24:20 localhost kernel: Unable to handle kernel NULL pointer
> Sep  6 11:24:20 localhost kernel: f8b05260
> Sep  6 11:24:20 localhost kernel: *pde = 00000000
> Sep  6 11:24:20 localhost kernel: Oops: 0000
> Sep  6 11:24:20 localhost kernel: CPU:    1
> Sep  6 11:24:20 localhost kernel: EIP:    0060:[<f8b05260>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> Sep  6 11:24:20 localhost kernel: EFLAGS: 00010246
> Sep  6 11:24:20 localhost kernel: eax: 00000100   ebx: 00000000   ecx:
> Warning (Oops_set_regs): garbage 'ecx:' at end of register line ignored
> 00033a64   edx: f653b980
> Sep  6 11:24:20 localhost kernel: esi: 00000000   edi: 00000000   ebp:
> Warning (Oops_set_regs): garbage 'ebp:' at end of register line ignored
> 00000000   esp: f5ebbe98
> Sep  6 11:24:20 localhost kernel: ds: 0068   es: 0068   ss: 0068
> Sep  6 11:24:20 localhost kernel: Process ip (pid: 3080,
stackpage=f5ebb000)
> Sep  6 11:24:20 localhost kernel: Stack: c3699400 00001000 f5e43000
f653b980
> c3699400 00001003 00000000 f8b051dd
> Sep  6 11:24:20 localhost kernel:        f653b980 14000000 f653b800
f653b800
> f653b980 00000000 f8b04a26 f653b980
> Sep  6 11:24:20 localhost kernel:        f653b800 c020fa86 f653b800
c02123c7
> f653b800 f653b800 00001002 c021112a
> Sep  6 11:24:20 localhost kernel: Call Trace:   [<f8b051dd>]
> e1000_free_rx_resources [e1000] 0x1d (0xf5ebbeb4))
> Sep  6 11:24:20 localhost kernel: [<f8b04a26>] e1000_open [e1000] 0x46
> Sep  6 11:24:20 localhost kernel: [<c020fa86>] dev_open [kernel] 0xa6
> Sep  6 11:24:20 localhost kernel: [<c02123c7>] dev_mc_upload [kernel] 0x37
> Sep  6 11:24:20 localhost kernel: [<c021112a>] dev_change_flags [kernel]
> 0x12a
> Sep  6 11:24:20 localhost kernel: [<c020f61e>] dev_get [kernel] 0x1e
> Sep  6 11:24:20 localhost kernel: [<c024f130>] devinet_ioctl [kernel]
0x290
> Sep  6 11:24:20 localhost kernel: [<c0207ca0>] sock_ioctl [kernel] 0x40
> Sep  6 11:24:20 localhost kernel: [<c01650b6>] sys_ioctl [kernel] 0xf6
> Sep  6 11:24:20 localhost kernel: [<c01098cf>] system_call [kernel] 0x33
> Sep  6 11:24:20 localhost kernel: Code: 8b 14 1f 85 d2 74 36 8b 42 70 48
74
> 0b
>
>
> >>EIP; f8b05260 <[e1000]e1000_clean_rx_ring+30/140>   <=====
>
> Trace; f8b051dd <[e1000]e1000_free_rx_resources+1d/70>
>
> Code;  f8b05260 <[e1000]e1000_clean_rx_ring+30/140>
> 00000000 <_EIP>:
> Code;  f8b05260 <[e1000]e1000_clean_rx_ring+30/140>   <=====
>    0:   8b 14 1f                  mov    (%edi,%ebx,1),%edx   <=====
> Code;  f8b05263 <[e1000]e1000_clean_rx_ring+33/140>
>    3:   85 d2                     test   %edx,%edx
> Code;  f8b05265 <[e1000]e1000_clean_rx_ring+35/140>
>    5:   74 36                     je     3d <_EIP+0x3d>
> Code;  f8b05267 <[e1000]e1000_clean_rx_ring+37/140>
>    7:   8b 42 70                  mov    0x70(%edx),%eax
> Code;  f8b0526a <[e1000]e1000_clean_rx_ring+3a/140>
>    a:   48                        dec    %eax
> Code;  f8b0526b <[e1000]e1000_clean_rx_ring+3b/140>
>    b:   74 0b                     je     18 <_EIP+0x18>
>
>
> 4 warnings and 6 errors issued.  Results may not be reliable.
>
>
> ===
>
> Please let me know if im missing something, or if you need more info from
me
> regarding this issue.
>
> Thanks a lot.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


