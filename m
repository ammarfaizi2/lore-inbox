Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbTIZUi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 16:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbTIZUi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 16:38:58 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:32231 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261571AbTIZUiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 16:38:55 -0400
Date: Fri, 26 Sep 2003 22:38:15 +0200
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test5-bk(today)] Badness in pci_find_subsys
Message-ID: <20030926203815.GA31674@neon.pearbough.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: pearbough.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just found this in my syslog messages:

Sep 26 19:31:59 neon kernel: Badness in pci_find_subsys at
drivers/pci/search.c:132
Sep 26 19:31:59 neon kernel: Call Trace:
Sep 26 19:31:59 neon kernel:  [<c01f5fd3>] pci_find_subsys+0xec/0xf4
Sep 26 19:31:59 neon kernel:  [<c01f600a>] pci_find_device+0x2f/0x33
Sep 26 19:31:59 neon kernel:  [<c01f5ec5>] pci_find_slot+0x27/0x49
Sep 26 19:31:59 neon kernel:  [<e1daf3a9>] os_pci_init_handle+0x39/0x65
[nvidia]
Sep 26 19:31:59 neon kernel:  [<e1c842af>] __nvsym00057+0x1f/0x24 [nvidia]
Sep 26 19:31:59 neon kernel:  [<e1d188e2>] __nvsym03763+0x72/0xe0 [nvidia]
Sep 26 19:31:59 neon kernel:  [<e1d5d3f1>] __nvsym04466+0x15/0x78 [nvidia]
Sep 26 19:31:59 neon kernel:  [<e1d94837>] __nvsym04875+0x127/0x170 [nvidia]
Sep 26 19:31:59 neon kernel:  [<e1d172ed>] __nvsym03749+0x41/0xbc [nvidia]
Sep 26 19:31:59 neon kernel:  [<e1d945da>] __nvsym00780+0x21a/0x224 [nvidia]
Sep 26 19:31:59 neon kernel:  [<e1d17c94>] __nvsym03741+0x74/0x88 [nvidia]
Sep 26 19:31:59 neon kernel:  [<e1d16c5a>] __nvsym03751+0x5a2/0x8a4 [nvidia]
Sep 26 19:31:59 neon kernel:  [<e1d5b233>] __nvsym00688+0x1e3/0x338 [nvidia]
Sep 26 19:31:59 neon kernel:  [<e1c869b9>] __nvsym00827+0xd/0x1c [nvidia]
Sep 26 19:31:59 neon kernel:  [<e1c88054>] rm_isr_bh+0xc/0x10 [nvidia]
Sep 26 19:31:59 neon kernel:  [<c0123734>] tasklet_action+0x40/0x61
Sep 26 19:31:59 neon kernel:  [<c0123586>] do_softirq+0x92/0x94
Sep 26 19:31:59 neon kernel:  [<c010b643>] do_IRQ+0x102/0x135
Sep 26 19:31:59 neon kernel:  [<c0109b70>] common_interrupt+0x18/0x20
Sep 26 19:31:59 neon kernel:



I guess this will help noone I guess, because my kernel is tainted with
nvidia module and the problem seems to originate from there. Does it?
Probably you don't even wanna see it, but still I believe
maybe this could be of help to someone.

Card is:
01:00.0 VGA compatible controller: nVidia Corporation NV11DDR [GeForce2 MX
100 DDR/200 DDR] (rev b2) (prog-if 00 [VGA])
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 16
        Memory at ea000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0


I can provide more information.
I should send this to nvidia maybe? Do they wanna see it? Because it's
2.6-related. Well..


Best regards,
Axel Siebenwirth

____________________________________________________________________________
Axel Siebenwirth				      phone +49 3641 776807 |
Am Birnstiel 3			 		  axel at pearbough dot net |
07745 Jena								    |
Germany________________________________________________http://pearbough.net |

America is the country where you buy a lifetime
supply of aspirin for one dollar, and use it up in two weeks.
____________________________________________________________________________
