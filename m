Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267021AbSK2LlV>; Fri, 29 Nov 2002 06:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267022AbSK2LlV>; Fri, 29 Nov 2002 06:41:21 -0500
Received: from cibs9.sns.it ([192.167.206.29]:61201 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S267021AbSK2LlU>;
	Fri, 29 Nov 2002 06:41:20 -0500
Date: Fri, 29 Nov 2002 12:48:42 +0100 (CET)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: asm/io_apic.h is missing in drivers/pci/quirks.c with kernel 2.5.50
Message-ID: <Pine.LNX.4.43.0211291247200.1275-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in file drivers/pci/quirks.c of linux kernel 2.5.50

#include <asm/io_apic.h>

is missing.


this include is necessary to avoid this error
in compilation time:

rivers/pci/quirks.c: In function `quirk_ioapic_rmw':
drivers/pci/quirks.c:354: `sis_apic_bug' undeclared (first use in this
function)
drivers/pci/quirks.c:354: (Each undeclared identifier is reported only
once
drivers/pci/quirks.c:354: for each function it appears in.)
make[2]: *** [drivers/pci/quirks.o] Error 1
make[1]: *** [drivers/pci] Error 2
make: *** [drivers] Error 2


