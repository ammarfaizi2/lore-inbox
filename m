Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUCXVaG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUCXVaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:30:06 -0500
Received: from fmr06.intel.com ([134.134.136.7]:35773 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261952AbUCXVaA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:30:00 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Export cpu_up & cpu_down functions
Date: Wed, 24 Mar 2004 13:29:40 -0800
Message-ID: <33561BB7A415E04FBDC339D5E149C6E2ACC209@orsmsx405.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Export cpu_up & cpu_down functions
Thread-Index: AcQR5x0V4E8SQBgsSrqZ+6vm2dRs/g==
From: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
To: <lhcs-devel@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Mar 2004 21:29:40.0740 (UTC) FILETIME=[1DBF2440:01C411E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,
	When acpi processor driver capable of handling cpu hotplug
notifications is compiled as module then this driver expects cpu_up()
and cpu_down() to be an exported functions. Attached patch exports those
functions. Please include this patch.

Thanks,
Anil Keshavamurthy 

--------------------------------

 linux-2.6.3-root/kernel/cpu.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN kernel/cpu.c~export_cpu_up_cpu_down kernel/cpu.c
--- linux-2.6.3/kernel/cpu.c~export_cpu_up_cpu_down     2004-03-24
21:18:38.418764404 -0800
+++ linux-2.6.3-root/kernel/cpu.c       2004-03-24 21:20:04.449081889
-0800
@@ -154,6 +154,7 @@ out:
        unlock_cpu_hotplug();
        return err;
 }
+EXPORT_SYMBOL(cpu_down);
 #else
 static inline int cpu_run_sbin_hotplug(unsigned int cpu, const char
*action)
 {
@@ -198,3 +199,4 @@ out:
        unlock_cpu_hotplug();
        return ret;
 }
+EXPORT_SYMBOL(cpu_up);

