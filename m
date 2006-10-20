Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWJTU5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWJTU5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWJTU5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:57:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61923 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030353AbWJTU5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:57:44 -0400
Date: Fri, 20 Oct 2006 13:57:42 -0700
From: Bryce Harrington <bryce@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc2-mm2 not building on ia64
Message-ID: <20061020205742.GU10386@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're seeing the following error building the 2.6.19-rc2-mm2 kernel on
ia64 (it builds ok on x86_64).  2.6.19-rc2-git4 builds ok.


  CC [M]  drivers/acpi/processor_throttling.o
arch/ia64/sn/kernel/setup.c: In function `sn_setup':
arch/ia64/sn/kernel/setup.c:470: error: `ia64_timestamp_clock' undeclared (first use in this function)
arch/ia64/sn/kernel/setup.c:470: error: (Each undeclared identifier is reported only once
arch/ia64/sn/kernel/setup.c:470: error: for each function it appears in.)
  CC      fs/ext2/namei.o
make[2]: *** [arch/ia64/sn/kernel/setup.o] Error 1
make[1]: *** [arch/ia64/sn/kernel] Error 2
make: *** [arch/ia64/sn] Error 2
make: *** Waiting for unfinished jobs....

Full logs:
   http://crucible.osdl.org/runs/2688/logs/ita01/kernel.config.log
   http://crucible.osdl.org/runs/2688/logs/ita01/kernel.make.log

Config file:
   http://crucible.osdl.org/runs/2688/sysinfo/ita01.config

Bryce

