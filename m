Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274971AbTHPV60 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 17:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274973AbTHPV60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 17:58:26 -0400
Received: from host81-128-40-169.in-addr.btopenworld.com ([81.128.40.169]:16685
	"EHLO worthy.swandive.local") by vger.kernel.org with ESMTP
	id S274971AbTHPV6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 17:58:24 -0400
Message-ID: <3F3EA8FD.1030000@btinternet.com>
Date: Sat, 16 Aug 2003 22:58:21 +0100
From: Grant Wilson <gww@btinternet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test3-bk4 compilation failures
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If my .config has ACPI enabled but CONFIG_X86_UP_IOAPIC not set then the 
compilation fails:

arch/i386/kernel/mpparse.c: In function `mp_config_ioapic_for_sci':
arch/i386/kernel/mpparse.c:1065: warning: implicit declaration of 
function `mp_find_ioapic'
arch/i386/kernel/mpparse.c:1067: error: `mp_ioapic_routing' undeclared 
(first use in this function)
arch/i386/kernel/mpparse.c:1067: error: (Each undeclared identifier is 
reported only once
arch/i386/kernel/mpparse.c:1067: error: for each function it appears in.)
arch/i386/kernel/mpparse.c:1069: warning: implicit declaration of 
function `io_apic_set_pci_routing'
arch/i386/kernel/mpparse.c: In function `mp_parse_prt':
arch/i386/kernel/mpparse.c:1113: error: `mp_ioapic_routing' undeclared 
(first use in this function)

If I then set both CONFIG_X86_UP_IOAPIC and CONFIG_X86_IO_APIC to 'y' 
the compilation fails:

drivers/ide/pci/amd74xx.c: In function `amd74xx_get_info':
drivers/ide/pci/amd74xx.c:107: error: structure has no member named `name'
drivers/ide/pci/amd74xx.c: In function `init_chipset_amd74xx':
drivers/ide/pci/amd74xx.c:368: error: structure has no member named `name'

-- Grant


