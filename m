Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSGYSh7>; Thu, 25 Jul 2002 14:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSGYSh6>; Thu, 25 Jul 2002 14:37:58 -0400
Received: from [213.4.129.129] ([213.4.129.129]:45375 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id <S315923AbSGYSh6>;
	Thu, 25 Jul 2002 14:37:58 -0400
From: <diegocg@teleline.es>
Subject: 2.5.28 OOPS with date
Message-Id: <20020725183758Z315923-685+18075@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
Date: Thu, 25 Jul 2002 14:37:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is a very short oops
it happened while doing _nothing_ (idle state)
oh, wait, this lne was run just before
Jul 25 16:35:01 diego /USR/SBIN/CRON[322]: (root) CMD (test -x /usr/lib/sysstat/sa1 && /usr/lib/sysstat/sa1)

the oops is here:
diego:~# ksymoops < bug
ksymoops 2.4.5 on i586 2.5.27.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.27/ (default)
     -m /boot/System.map-2.5.27 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jul 25 16:35:01 diego kernel: Unable to handle kernel paging request at virtual address 401340c8
Jul 25 16:35:01 diego kernel: 400082d3
Jul 25 16:35:01 diego kernel: *pde = 017ee067
Jul 25 16:35:01 diego kernel: Oops: 0006
Jul 25 16:35:01 diego kernel: CPU:    0
Jul 25 16:35:01 diego kernel: EIP:    0023:[pnpbios_proc_exit+1073773491/-1072695072]    Not tainted
Jul 25 16:35:01 diego kernel: EFLAGS: 00010246
Jul 25 16:35:01 diego kernel: eax: 401340c8   ebx: 400130ec   ecx: 40034710   edx: 40032d38
Jul 25 16:35:01 diego kernel: esi: 4001f000   edi: 40030570   ebp: bffff924   esp: bffff86c
Jul 25 16:35:01 diego kernel: ds: 002b   es: 002b   ss: 002b
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; 401340c8 Before first symbol
>>ebx; 400130ec Before first symbol
>>ecx; 40034710 Before first symbol
>>edx; 40032d38 Before first symbol
>>esi; 4001f000 Before first symbol
>>edi; 40030570 Before first symbol
>>ebp; bffff924 Before first symbol
>>esp; bffff86c Before first symbol


2 warnings issued.  Results may not be reliable.


regards, Diego Calleja <diegocg@teleline.es>
