Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbRE0LPE>; Sun, 27 May 2001 07:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbRE0LOz>; Sun, 27 May 2001 07:14:55 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:33810 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S261617AbRE0LOt>; Sun, 27 May 2001 07:14:49 -0400
Date: Sun, 27 May 2001 12:41:17 +0200
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: new aic7xxx oopses with AHA2940
Message-ID: <20010527124117.A20142@lisa.links2linux.home>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20010526180529.A7595@lisa.links2linux.home> <21164.990925636@ocs3.ocs-net> <20010527042129.A12765@lisa.links2linux.home> <3B106844.6161CFE0@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B106844.6161CFE0@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, May 26, 2001 at 10:36:52PM -0400
X-Operating-System: Linux 2.2.18-lisa01 i586
X-Editor: VIM 5.7.8
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik schrieb am 27.05.01 um 04:36 Uhr:
> 
> I'm curious what happens with the attached patch?
> 
> It adds some debugging checks which will halt your kernel with "BUG! at
> <file>:line"...
> 
[patch]

I got your PM. How did you make it?

I updated ksymoops to 2.4.1, applied the patch and traced again, but
I think there is no difference now, is it?


ksymoops 2.4.1 on i686 2.4.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
May 27 12:30:47 homer kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
May 27 12:30:47 homer kernel: e0a7b3a7
May 27 12:30:47 homer kernel: *pde = 00000000
May 27 12:30:47 homer kernel: Oops: 0000
May 27 12:30:47 homer kernel: CPU:    0
May 27 12:30:47 homer kernel: EIP:    0010:[<e0a7b3a7>]
Using defaults from ksymoops -t elf32-i386 -a i386
May 27 12:30:47 homer kernel: EFLAGS: 00010096
May 27 12:30:47 homer kernel: eax: 00000041   ebx: 00000000   ecx: 00000000   edx: dd570c00
May 27 12:30:47 homer kernel: esi: 00000000   edi: 000000ff   ebp: dd570c00   esp: dd221cbc
May 27 12:30:47 homer kernel: ds: 0018   es: 0018   ss: 0018
May 27 12:30:47 homer kernel: Process modprobe (pid: 474, stackpage=dd221000)
May 27 12:30:47 homer kernel: Stack: 00000000 00000000 000000ff dd570c00 41000357 e0a7b7cd dd570c00 00000000 
May 27 12:30:47 homer kernel:        ffffffff 00000041 ffffffff 000000ff 00000000 00000041 00000000 dd570c00 
May 27 12:30:47 homer kernel:        dd570c00 00000001 00000001 00000001 00000001 00000001 00000000 00000001 
May 27 12:30:47 homer kernel: Call Trace: [<e0a7b7cd>] [<e0a7c256>] [<c0234ce3>] [<e0a7c84d>] [<e0a70990>] [<e0a812e9>] [<e0a7dcd7>] 
May 27 12:30:47 homer kernel:        [<c0230000>] [<e0a6f93e>] [<e0a78855>] [<e0a6f891>] [<e0a6f8b0>] [<e0a852e0>] [<c011b3c2>] [<c01d6fdc>] 
May 27 12:30:47 homer kernel:        [<e0a85360>] [<e0a853c0>] [<c01d7054>] [<e0a853c0>] [<e0a852e0>] [<e0a7287a>] [<e0a6f74e>] [<e0a852e0>] 
May 27 12:30:47 homer kernel:        [<e0a6f068>] [<c01bf7d9>] [<e0a852e0>] [<e0a852e0>] [<e0a6f068>] [<e0a7cccc>] [<e0a6f000>] [<e0a6f068>] 
May 27 12:30:47 homer kernel:        [<c01c003d>] [<e0a852e0>] [<e0a6f000>] [<e0a726d6>] [<e0a852e0>] [<c011541d>] [<e0a68000>] [<e0a6f060>] 
May 27 12:30:47 homer kernel:        [<c0106b9b>] 
May 27 12:30:47 homer kernel: Code: 8b 06 8b 7c 24 20 8b 6c 24 28 0f b6 40 19 f6 82 f0 00 00 00 

>>EIP; e0a7b3a7 <[aic7xxx]ahc_match_scb+17/f0>   <=====
Trace; e0a7b7cd <[aic7xxx]ahc_search_qinfifo+14d/6b0>
Trace; e0a7c256 <[aic7xxx]ahc_abort_scbs+66/300>
Trace; c0234ce3 <__delay+13/30>
Trace; e0a7c84d <[aic7xxx]ahc_reset_channel+25d/370>
Trace; e0a70990 <[aic7xxx]ahc_linux_isr+0/270>
Trace; e0a812e9 <[aic7xxx].rodata.start+c89/157c>
Trace; e0a7dcd7 <[aic7xxx]ahc_pci_config+497/4b0>
Trace; c0230000 <rpc_new_task+f0/170>
Trace; e0a6f93e <[aic7xxx]ahc_linux_initialize_scsi_bus+3e/1d0>
Trace; e0a78855 <[aic7xxx]ahc_set_name+15/30>
Trace; e0a6f891 <[aic7xxx]ahc_linux_register_host+111/150>
Trace; e0a6f8b0 <[aic7xxx]ahc_linux_register_host+130/150>
Trace; e0a852e0 <[aic7xxx]driver_template+0/6c>
Trace; c011b3c2 <timer_bh+222/260>
Trace; c01d6fdc <pci_announce_device+1c/50>
Trace; e0a85360 <[aic7xxx]ahc_linux_pci_id_table+0/60>
Trace; e0a853c0 <[aic7xxx]aic7xxx_pci_driver+0/20>
Trace; c01d7054 <pci_register_driver+44/60>
Trace; e0a853c0 <[aic7xxx]aic7xxx_pci_driver+0/20>
Trace; e0a852e0 <[aic7xxx]driver_template+0/6c>
Trace; e0a7287a <[aic7xxx]ahc_linux_pci_probe+a/30>
Trace; e0a6f74e <[aic7xxx]ahc_linux_detect+5e/90>
Trace; e0a852e0 <[aic7xxx]driver_template+0/6c>
Trace; e0a6f068 <[aic7xxx].text.start+8/a0>
Trace; c01bf7d9 <scsi_register_host+49/2d0>
Trace; e0a852e0 <[aic7xxx]driver_template+0/6c>
Trace; e0a852e0 <[aic7xxx]driver_template+0/6c>
Trace; e0a6f068 <[aic7xxx].text.start+8/a0>
Trace; e0a7cccc <[aic7xxx]ahc_check_patch+c/80>
Trace; e0a6f000 <[eepro100]__module_parm_multicast_filter_limit+3124/3184>
Trace; e0a6f068 <[aic7xxx].text.start+8/a0>
Trace; c01c003d <scsi_register_module+2d/60>
Trace; e0a852e0 <[aic7xxx]driver_template+0/6c>
Trace; e0a6f000 <[eepro100]__module_parm_multicast_filter_limit+3124/3184>
Trace; e0a726d6 <[aic7xxx]init_this_scsi_driver+16/40>
Trace; e0a852e0 <[aic7xxx]driver_template+0/6c>
Trace; c011541d <sys_init_module+4fd/5a0>
Trace; e0a68000 <[emu10k1].data.end+23f9/2459>
Trace; e0a6f060 <[aic7xxx]ahc_print_path+0/0>
Trace; c0106b9b <system_call+33/38>
Code;  e0a7b3a7 <[aic7xxx]ahc_match_scb+17/f0>
00000000 <_EIP>:
Code;  e0a7b3a7 <[aic7xxx]ahc_match_scb+17/f0>   <=====
   0:   8b 06                     mov    (%esi),%eax   <=====
Code;  e0a7b3a9 <[aic7xxx]ahc_match_scb+19/f0>
   2:   8b 7c 24 20               mov    0x20(%esp,1),%edi
Code;  e0a7b3ad <[aic7xxx]ahc_match_scb+1d/f0>
   6:   8b 6c 24 28               mov    0x28(%esp,1),%ebp
Code;  e0a7b3b1 <[aic7xxx]ahc_match_scb+21/f0>
   a:   0f b6 40 19               movzbl 0x19(%eax),%eax
Code;  e0a7b3b5 <[aic7xxx]ahc_match_scb+25/f0>
   e:   f6 82 f0 00 00 00 00      testb  $0x0,0xf0(%edx)


2 warnings issued.  Results may not be reliable.


-- 
+------------------------------------------------------------------+
| --> http://www.links2linux.de <-- Jetzt mit neuen Features!      |
|                                   wie z.B. [EasyLink]            |
+---Registered-Linux-User-#136487------------http://counter.li.org +
