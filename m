Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbVAFNr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbVAFNr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVAFNrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:47:37 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:54764 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262829AbVAFNrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:47:20 -0500
Date: Thu, 6 Jan 2005 14:47:14 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-bk8 swapoff after resume
Message-ID: <20050106134714.GB24188@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've tried 2.6.10-bk8 suspend/resume. After resume I usually do swapoff -a to
load all the pages from swap to memory. Unfortunately with the latest version
swapoff does not work. It seems to cycle in an endless loop reading data from 
disk.

According to sysrq show regs:

Pid: 2401, comm:              swapoff
EIP: 0060:[<c01493d8>] CPU: 0
EIP is at unuse_process+0x41/0xc2
 EFLAGS: 00200246    Not tainted  (2.6.10-bk8)
EAX: 00000000 EBX: d790df90 ECX: b7218000 EDX: 17902001
ESI: d7805d00 EDI: d7805d2c EBP: c1315960 DS: 007b ES: 007b
CR0: 8005003b CR2: b6e1d000 CR3: 18ad0000 CR4: 00000690
 [<c01496df>] try_to_unuse+0x238/0x5cc
 [<c015d7bd>] getname+0x75/0xbd
 [<c0149f88>] sys_swapoff+0x184/0x3bc
 [<c0102f87>] syscall_call+0x7/0xb

-- 
Luká¹ Hejtmánek
