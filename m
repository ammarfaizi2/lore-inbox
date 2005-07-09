Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263109AbVGIFMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbVGIFMa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 01:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbVGIFM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 01:12:29 -0400
Received: from gherkin.frus.com ([192.158.254.49]:17046 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S263109AbVGIFMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 01:12:22 -0400
Subject: 2.6.12 vs. /sbin/cardmgr
To: linux-pcmcia@lists.infradead.org
Date: Sat, 9 Jul 2005 00:12:17 -0500 (CDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20050709051217.A4F0FDBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a Mandrake 10.0 system with a 2.6.12 kernel presently.
Somewhere between 2.6.11 and 2.6.12, /sbin/cardmgr from the
pcmcia-cs-3.2.5-3mdk package decided it needs to consume incredible
amounts of CPU time when invoked the first time following a boot.
You can definitely notice the load on the system.

Stopping cardmgr requires a "kill -9": softer kills are ignored.
Restarting cardmgr produces the following output:

cardmgr[3731]: watching 2 sockets
cardmgr[3731]: could not adjust resource: IO ports 0xc00-0xcff: Device or resource busy
cardmgr[3731]: could not adjust resource: IO ports 0x100-0x4ff: Device or resource busy
cardmgr[3731]: could not adjust resource: memory 0xc0000-0xfffff: Input/output error
cardmgr[3731]: could not adjust resource: memory 0x60000000-0x60ffffff: Input/output error
cardmgr[3731]: could not adjust resource: memory 0xa0000000-0xa0ffffff: Input/output error
cardmgr[3731]: could not adjust resource: IO ports 0x1000-0x1fff: Device or resource busy
cardmgr[3731]: could not adjust resource: IO ports 0xa00-0xaff: Device or resource busy

But at least it doesn't seem to be running around in tight circles at
this point :-).

System is a Dell Latitude CPxJ notebook that continues to work fine
with 2.6.11 and older kernels.  Any idea what changed between 2.6.11
and 2.6.12 that might be causing this problem?  I can probably provide
more info on request.

As usual, thanks in advance.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
