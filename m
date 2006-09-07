Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWIGSUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWIGSUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWIGSUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:20:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:10978 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751019AbWIGSUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:20:45 -0400
Subject: [Bug] [2.6.18-rc5-mm1] system no boot early death  x86_64
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: mel@csn.ul.ie, andrew <akpm@osdl.org>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 07 Sep 2006 11:20:41 -0700
Message-Id: <1157653241.5653.37.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I was booting rc4-mm3.  With rc5-mm1 I am hanging early... Mel I don't
know if this is related to your code but I will soon know. (I don't get
your debug info in early console.)  
  I was working on patches for the reserve based memory hot add path in
srat.c (the initial error is fixed by Mels patches but there is more to
do) and was just moving to rc5-mm1 to sync up and then more trouble.
This is with reserve based hot-add not enabled at the command line. 


Linux version 2.6.18-rc5-mm1-smp (root@elm3a153) (gcc version 4.1.0
(SUSE Linux)) #2 SMP Wed Sep 6 21:04:22 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000098400 (usable)
 BIOS-e820: 0000000000098400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff85e00 (usable)
 BIOS-e820: 000000007ff85e00 - 000000007ff98880 (ACPI data)
 BIOS-e820: 000000007ff98880 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000470000000 (usable)
 BIOS-e820: 0000001070000000 - 0000001160000000 (usable)
end_pfn_map = 18219008
kernel direct mapping tables up to 1160000000 @ 8000-4f000
DMI 2.3 present.
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 0 -> APIC 2 -> Node 0
SRAT: PXM 0 -> APIC 3 -> Node 0
SRAT: PXM 0 -> APIC 38 -> Node 0
SRAT: PXM 0 -> APIC 39 -> Node 0
SRAT: PXM 0 -> APIC 36 -> Node 0
SRAT: PXM 0 -> APIC 37 -> Node 0
SRAT: PXM 1 -> APIC 64 -> Node 1
SRAT: PXM 1 -> APIC 65 -> Node 1
SRAT: PXM 1 -> APIC 66 -> Node 1
SRAT: PXM 1 -> APIC 67 -> Node 1
SRAT: PXM 1 -> APIC 102 -> Node 1
SRAT: PXM 1 -> APIC 103 -> Node 1
SRAT: PXM 1 -> APIC 100 -> Node 1
SRAT: PXM 1 -> APIC 101 -> Node 1
SRAT: Node 0 PXM 0 0-80000000
SRAT: Node 0 PXM 0 0-470000000
SRAT: Node 1 PXM 1 1070000000-1160000000
Bootmem setup node 0 0000000000000000-0000000470000000



