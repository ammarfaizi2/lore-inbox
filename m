Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267598AbSLNLrr>; Sat, 14 Dec 2002 06:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267601AbSLNLrr>; Sat, 14 Dec 2002 06:47:47 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:39127 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267598AbSLNLrr>; Sat, 14 Dec 2002 06:47:47 -0500
Message-Id: <4.3.2.7.2.20021214124403.00ae5f00@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 14 Dec 2002 12:55:55 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: 2.5.51 cpufeatures.h
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhat confused.
In include/asm-i386/cpufeature.h we have:
--snip--
#define X86_FEATURE_XMM2        (0*32+26) /* Streaming SIMD Extensions-2 */
#define X86_FEATURE_SELFSNOOP   (0*32+27) /* CPU self snoop */
#define X86_FEATURE_HT          (0*32+28) /* Hyper-Threading */
#define X86_FEATURE_ACC         (0*32+29) /* Automatic clock control 
*/      <---- ******
#define X86_FEATURE_IA64        (0*32+30) /* IA-64 processor */
--end snip--

According to Intel specs, bit 29 is :
" TM  Thermal Monitor    The processor implements the thermal monitor automatic
   thermal control circuitry (TMM)"

The (wrong?) FEATURE ACC is used in
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
arch/i386/kernel/cpu/mcheck/p4.c

Margit 

