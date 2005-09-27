Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVI0JL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVI0JL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 05:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbVI0JL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 05:11:59 -0400
Received: from aun.it.uu.se ([130.238.12.36]:12444 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S964870AbVI0JL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 05:11:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17209.3253.586434.244861@alkaid.it.uu.se>
Date: Tue, 27 Sep 2005 11:11:17 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Grant Grundler <grundler@parisc-linux.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       ak@suse.de
Subject: Re: [PATCH] MSI interrupts: disallow when no LAPIC/IOAPIC support
In-Reply-To: <20050926215245.7a1be7fa.rdunlap@xenotime.net>
References: <20050926201156.7b9ef031.rdunlap@xenotime.net>
	<20050927044840.GA21108@colo.lackof.org>
	<20050926215245.7a1be7fa.rdunlap@xenotime.net>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap writes:
 > "nosmp" (currently) means 1 CPU and no LAPICs/no IOAPICs.

nosmp shouldn't disable the local APIC or the I/O APIC(s).
If it really does, then that's a bug.  We have noapic/nolapic/lapic
to control enablement of the APICs.
