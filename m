Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135854AbREAOlR>; Tue, 1 May 2001 10:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136620AbREAOlG>; Tue, 1 May 2001 10:41:06 -0400
Received: from jalon.able.es ([212.97.163.2]:7651 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S135947AbREAOjy>;
	Tue, 1 May 2001 10:39:54 -0400
Date: Tue, 1 May 2001 16:39:47 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: APIC asymmetry in SMP ?
Message-ID: <20010501163947.A1278@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Looking over one other problem, I realized that my 2 cpus are recognized
slightly different in the <setup_APIC_timer> function:

cpu: 0, clocks: 1002324, slice: 334108
CPU0<T0:1002320,T1:668208,D:4,S:334108,C:1002324>
cpu: 1, clocks: 1002324, slice: 334108
CPU1<T0:1002320,T1:334096,D:8,S:334108,C:1002324>

Both are just the same, both pII@400, 512Kb:

CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Pentium II (Deschutes) stepping 02
.
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
CPU1: Intel Pentium II (Deschutes) stepping 02

???

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.4-ac1 #1 SMP Tue May 1 11:35:17 CEST 2001 i686

