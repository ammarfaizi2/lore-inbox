Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbTFSBeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbTFSBeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:34:36 -0400
Received: from fe5.rdc-kc.rr.com ([24.94.163.52]:50697 "EHLO mail5.kc.rr.com")
	by vger.kernel.org with ESMTP id S265692AbTFSBeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:34:25 -0400
Date: Wed, 18 Jun 2003 20:48:23 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.72 oops (scheduling while atomic)
Message-ID: <20030619014822.GA5705@glitch.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <20030617143551.GA3057@glitch.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20030617143551.GA3057@glitch.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I just re-tested with 2.5.72-bk1, which still experiences the problem. 
I enabled all of the debugging options this time, however, and so
captured what I hope to be a more informative oops.  The .config was
otherwise unchanged.

Let me know if I can provide any additional information.


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oops-decoded

ksymoops 2.4.8 on i686 2.4.21.  Options used
     -v ../vmlinux_glitch.1 (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map-2.5.72-bk1 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace:
 [<c011c4f3>] schedule+0x607/0x60c
 [<c010a0ea>] apic_timer_interrupt+0x1a/0x20
 [<c01070e9>] default_idle+0x0/0x31
 [<c01070e9>] default_idle+0x0/0x31
 [<c01071a3>] cpu_idle+0x0x51/0x53
 [<c0105000>] _stext+0x0/0x92
 [<c0320842>] start_kernel+0x16d/0x185
 [<c0320432>] unknown_bootoption+0x0/0xf8
Unable to handle kernel paging request at virtual address 40128560
400d2aa3
*pde = 3ff58067
Oops:   0007 [#1]
CPU:    0
EIP:    0073:[<400d2aa3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: 40128560  ebx: 0804d5e9  ecx: 00000002  edx: 00000002
esi: 00000005  edi: 0804d5e9  ebp: bffffbe8  esp: bffff8bc
ds: 007b  es: 007b  ss: 007b
 <0>Kernel panic: Attempted to kill init!
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c011c4f3 <schedule+607/60c>
Trace; c010a0ea <apic_timer_interrupt+1a/20>
Trace; c01070e9 <default_idle+0/31>
Trace; c01070e9 <default_idle+0/31>
Trace; c01071a3 <cpu_idle+51/53>
Trace; c0105000 <_stext+0/0>
Trace; c0320842 <start_kernel+16d/185>
Trace; c0320432 <unknown_bootoption+0/f8>

>>EIP; 400d2aa3 <__crc_param_set_short+8c15a/1fb35f>   <=====

>>eax; 40128560 <__crc_param_set_short+e1c17/1fb35f>
>>ebx; 0804d5e9 <__crc___mntput+21e4fc/396ec3>
>>edi; 0804d5e9 <__crc___mntput+21e4fc/396ec3>
>>ebp; bffffbe8 <__crc_input_register_handler+86aeb4/8a7903>
>>esp; bffff8bc <__crc_input_register_handler+86ab88/8a7903>


1 warning issued.  Results may not be reliable.

--zYM0uCDKw75PZbzx--
