Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263968AbTEFQuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTEFQux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:50:53 -0400
Received: from pD9E2380C.dip.t-dialin.net ([217.226.56.12]:64220 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id S263968AbTEFQup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:50:45 -0400
Date: Wed, 7 May 2003 15:41:27 +0200
From: Thunder Anklin <thunder@keepsake.ch>
To: linux-kernel@vger.kernel.org
Cc: tao@acc.umu.se
Subject: [OOPS] tmscsim broken on 2.0.40-rc6 as well
Message-ID: <20030507134127.GH816@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Location: Dorndorf-Steudnitz, Germany
X-GPG-KeyID: 0x30F8436E
X-GPG-Fingerprint: 22F7 F950 CCCF DC35 408C  4A4C 2CDE 7159 E070 C1EC
X-GPG-Key: http://lightweight.ods.org/~thunder/thunder.asc
X-Priority: I really don't care.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salut,

tmscsim looks broken to me on Linux 2.0.40-rc6 as well.

Ahm, and  BTW, the  version postfix is  set incorrectly.  I definitely
have 2.0.40-rc6 where it says it was 2.0.40-rc5.

Things worked OK in 2.0.36, BTW.

Options used: -V (default)
              -o /lib/modules/2.0.40-rc5/ (default)
              -k /proc/ksyms (default)
              -l /proc/modules (default)
              -m /boot/System.map-2.0.40 (specified)
              -c 1 (default)

CPU:    0
EIP:    0010:[<02811afe>]
EFLAGS: 00010007
eax: e0e0e0e0   ebx: 00e78018   ecx: 0110e810   edx: e0e0e0e0
esi: 0110e910   edi: 0110e860   ebp: 00937198   esp: 001ce5e8
ds: 0018   es: 0018   fs: 002b   gs: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=001cc72c)
Stack: 0110e910 00937198 0110e860 00000004 0110e810 0281143f 0110e860 00937198 
       0110e910 0009e820 0110e860 0000000a 001d2758 0033ac38 0281056c 0110e860 
       0009e858 0000000a 04000000 00000004 0003338b 001ce664 00113fc0 00000006 
Call Trace: [<0281143f>] [<0281056c>] [<00113fc0>] [<0010e0e9>] [<0010d92f>] [<0010aee8>] [<0010be89>] 
       [<001097f0>] [<001095ad>] 
Code: 39 72 0c 74 09 90 8b 52 0c 39 72 0c 75 f8 8b 46 0c 89 42 0c 

>>EIP: 02811afe <cleanup_module+49f6/????>
Trace: 0281143f <cleanup_module+4337/????>
Trace: 0281056c <cleanup_module+3464/????>
Trace: 00113fc0 <timer_bh+100/334>
Trace: 0010e0e9 <do_IRQ+65/88>
Trace: 0010d92f <IRQ10_interrupt+5f/84>
Trace: 0010aee8 <sys_idle+5c/70>
Trace: 0010be89 <system_call+55/7c>
Trace: 001097f0 <init+0/360>
Code:  02811afe <cleanup_module+49f6/????>     00000000 <_EIP>: <===
Code:  02811afe <cleanup_module+49f6/????>        0:	39 72 0c          	cmpl   %esi,0xc(%edx) <===
Code:  02811b01 <cleanup_module+49f9/????>        3:	74 09             	je      02811b0c <cleanup_module+4a04/????>
Code:  02811b03 <cleanup_module+49fb/????>        5:	90                	nop    
Code:  02811b04 <cleanup_module+49fc/????>        6:	8b 52 0c          	movl   0xc(%edx),%edx
Code:  02811b07 <cleanup_module+49ff/????>        9:	39 72 0c          	cmpl   %esi,0xc(%edx)
Code:  02811b0a <cleanup_module+4a02/????>        c:	75 f8             	jne     02811b04 <cleanup_module+49fc/????>
Code:  02811b0c <cleanup_module+4a04/????>        e:	8b 46 0c          	movl   0xc(%esi),%eax
Code:  02811b0f <cleanup_module+4a07/????>       11:	89 42 0c          	movl   %eax,0xc(%edx)

Aiee, killing interrupt handler

2 warnings issued.  Results may not be reliable.

			Thunder
