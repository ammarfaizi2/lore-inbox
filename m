Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUEUScQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUEUScQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 14:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265967AbUEUScQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 14:32:16 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:4501 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S265910AbUEUScL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 14:32:11 -0400
Mime-Version: 1.0
Message-Id: <a06100547bcd3f33b5b73@[129.98.90.227]>
Date: Fri, 21 May 2004 14:32:36 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: tg3 module in kernel 2.6.5 panics
Cc: aj@andaco.de, davem@nuts.davemloft.net, mchan@broadcom.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The tg3 module in (gentoo) kernel 2.6.5 panics on boot on a 
dual-opteron 248 box with 4G RAM. I copied the following screen 
output...

CS: 0010 DS: 0000 ES: 0000 CR0: 00000008005003b
CR2: ffffffffa00c8618 CR3: 00000000037855000 CR4: 00000000000006e0
Process modprobe (pid: 5317, stackpage = 100fbeedd00)
stack: ffffffffa00c4758 000000000ffffffea ffffffffa00c4728 ffffffff802ad0c8
0000000000000000 ffffffffa00c4758 ffffffff805ca9c0 ffffffff80306676
0000000000000000 ffffffffa00c46e0
call trace: < 
ffffffff802ad0c8>{kobject_register+40}<ffffffff80306676>{bus_add_driver+86}
<ffffffff802380e0{pci_register_driver+128}<ffffffffa00c06010>{:tg3:tg3_init 
+16}
<ffffffff80157404>{sys_init_module+436}<ffffffff80110e24>{system_call+124>

code: 48 89 11 48 4c 08 48 8b 43 38 48 8b 38 48 83 c7 78 e8 31
RIP <ffffffff802ad048>{kobject_add+120} RSP<00000100f9ae3eb8>
CR2: ffffffffa00c8618
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
