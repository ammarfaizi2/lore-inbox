Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbUCEOmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbUCEOmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:42:45 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:61706 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S262611AbUCEOmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:42:44 -0500
Date: Fri, 5 Mar 2004 15:42:40 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-rc2 (and earlier) - conflicting types for `linux_cpus' on sparc
Message-ID: <20040305144240.GI29693@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      arch/sparc/kernel/devices.o
arch/sparc/kernel/devices.c:18: error: conflicting types for `linux_cpus'
include/asm/smp.h:37: error: previous declaration of `linux_cpus'
make[1]: *** [arch/sparc/kernel/devices.o] Error 1
make: *** [arch/sparc/kernel] Error 2

kernel/devices.c contains:
struct prom_cpuinfo linux_cpus[32];

while asm-sparc/smp.h contains:
extern struct prom_cpuinfo linux_cpus[NR_CPUS];

I suppose it should be [NR_CPUS] in the first place too?


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/
