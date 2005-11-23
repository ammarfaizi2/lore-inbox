Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVKWC70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVKWC70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVKWC70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:59:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932477AbVKWC70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:59:26 -0500
Date: Tue, 22 Nov 2005 19:02:02 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: 2.6.15-git latest build broken on UP x86-64
Message-ID: <20051122190202.40efabfb@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.9.15 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks new, it happens on Fedora Core 4 with UP x86-64.

arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c:225: error: ‘ipi_handler’ undeclared (first use in this function)
arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c:225: error: (Each undeclared identifier is reported only once
arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c:225: error: for each function it appears in.)
make[2]: *** [arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.o] Error 1
make[2]: Target `__build' not remade because of errors.
make[1]: *** [arch/x86_64/kernel/../../i386/kernel/cpu/mtrr] Error 2

arch/x86_64/kernel/nmi.c:155: error: ‘nmi_cpu_busy’ undeclared (first use in this function)
arch/x86_64/kernel/nmi.c:155: error: (Each undeclared identifier is reported only once
arch/x86_64/kernel/nmi.c:155: error: for each function it appears in.)
make[1]: *** [arch/x86_64/kernel/nmi.o] Error 1
make[1]: Target `__build' not remade because of errors.
make: *** [arch/x86_64/kernel] Error 2
