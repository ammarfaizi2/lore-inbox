Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUCVOth (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 09:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUCVOth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 09:49:37 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:32175 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262040AbUCVOtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 09:49:32 -0500
Date: Mon, 22 Mar 2004 15:49:26 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.25 SMP - BUG at page_alloc.c:105
Message-ID: <20040322144926.GD31615@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found this in the logs of a Dual Athlon MP machine (Tyan board)
running 2.4.25-SMP:

kernel BUG at page_alloc.c:105! 
invalid operand: 0000 
CPU:    0 
EIP: 0010:[__free_pages_ok+80/704]    Not tainted 
EFLAGS: 00010286 
eax: c0333674   ebx: c1b2d720   ecx: 00000000   edx: f22f7a84 
esi: 00000001   edi: 00000000   ebp: 00000001   esp: f6901e3c 
ds: 0018   es: 0018   ss: 0018 
Process svscan (pid: 1348, stackpage=f6901000) 
Stack: c033364c f741cbc0 f22f7a84 00000001 0804c000 c0133ea6 f22f79c0 00000004  
       00000001 00000001 0804c000 00000001 c01308fa c1b2d720 f68e3080 0804b000  
       00001000 0844b000 c03ac4e0 00000001 0804c000 f68e3084 f42baa40 f7212440  
Call Trace: [set_page_dirty+166/176] [zap_page_range+330/400] [exit_mmap+221/352] [mmput+88/176] [do_exit+259/800] 
  [sig_exit+195/208] [dequeue_signal+95/192] [do_signal+448/694] [schedule_timeout+94/176] [process_timeout+0/96] [sys_nanosleep+232/448] 
  [do_page_fault+0/1347] [signal_return+20/24] 

Other than this BUG (that took down the machine hard, I was lucky to log
across the network), there appear to be no relevant logs shortly before
this crash.

What's causing this?

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
