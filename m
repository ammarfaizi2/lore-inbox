Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268528AbTCAI0y>; Sat, 1 Mar 2003 03:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268529AbTCAI0y>; Sat, 1 Mar 2003 03:26:54 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:64090
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268528AbTCAI0y>; Sat, 1 Mar 2003 03:26:54 -0500
Date: Sat, 1 Mar 2003 03:35:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC][0/2] per-CPU IDTs aka booting high irq count ia32 boxes
Message-ID: <Pine.LNX.4.50.0303010323210.2365-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently tackling booting a box with over 8 IOAPICs which results in 
320 interrupt sources. We won't be able to take all 320 obviously and 
stuck with 255 but i have a scheme for trying to 'increase' the global 
vector space by only installing vectors for irqs which the cpus on that 
node will be servicing. To achieve this i've first setup per cpu IDTs and 
then splitting up vector allocation to allocate per node.

I'm currently booting on a 16way but will be wiring up a 32way over the 
weekend.

dmesg: http://function.linuxpower.ca/patches/numaq/dmesg-4quad-percpu_idt
mptable: http://function.linuxpower.ca/patches/numaq/mptables-numaq-4quad

I'd appreciate any comments on the following patches. Boot and run on UP, 
SMP, NUMAQ/SMP

Thanks,
	Zwane
-- 
function.linuxpower.ca
