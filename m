Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312335AbSC3B1b>; Fri, 29 Mar 2002 20:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312345AbSC3B1W>; Fri, 29 Mar 2002 20:27:22 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:55560 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S312335AbSC3B1I>; Fri, 29 Mar 2002 20:27:08 -0500
Date: Sat, 30 Mar 2002 02:27:03 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Kernel hosed or Nvidia modules?
Message-ID: <20020330012703.GA16583@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is that a genuine kernel bug (2.4.19-pre2-ac3 here) or Yet Another
Nvidia Driver Bug (would not be the first bug to bite me in their
driver)? The Nvidia driver is configured to use the kernel AGP rather
than the Nvidia AGP. (TNT board, FWIW).

This does not happen frequently. Does anyone have a contact address at
Nvidia so I can show them as well?

NVRM: AGPGART: freed 16 pages
NVRM: AGPGART: backend released
kernel BUG at page_alloc.c:131!
invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+325/788]    Tainted: P
EFLAGS: 00013286
eax: 00000020   ebx: c1216aa8   ecx: c02d6d00   edx: 00005917
esi: 00001000   edi: 00000000   ebp: 4042a000   esp: cbae7ef0
ds: 0018   es: 0018   ss: 0018
Process X (pid: 1064, stackpage=cbae7000)
Stack: c02782f0 00000083 c1216aa8 00001000 00000000 4042a000 00000001 c1216aa8
       00001000 c1216aa8 00001000 c012c3a9 c012c87f c1216aa8 c01200f9 c1216aa8
       cbd2e0a8 c012055b 0a483067 caa8c800 00001000 4002a000 00000000 cbaec404
Call Trace: [__free_pages+29/32] [free_page_and_swap_cache+51/56] [__free_pte+73/80] [zap_page_range+423/592] [do_munmap+443/568] [sys_munmap+53/84] [system_call+51/64]
kernel:
Code: 0f 0b 83 c4 08 8d b6 00 00 00 00 8b 43 18 24 eb 89 43 18 c6

ksymoops said "before first symbol".

-- 
Matthias Andree
