Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbUKQKyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbUKQKyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbUKQKwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:52:47 -0500
Received: from aun.it.uu.se ([130.238.12.36]:47349 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262268AbUKQKuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:50:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16795.11468.681748.425014@alkaid.it.uu.se>
Date: Wed, 17 Nov 2004 11:49:48 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Sumit Pandya" <sumit@elitecore.com>
Cc: <linux-kernel@vger.kernel.org>, <len.brown@intel.com>
Subject: Re: OOPS - APIC or othere?
In-Reply-To: <HGEFKOBCHAIJDIEJLAKDGEMECAAA.sumit@elitecore.com>
References: <HGEFKOBCHAIJDIEJLAKDGEMECAAA.sumit@elitecore.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sumit Pandya writes:
 > Hi All,
 > 	At one of our client I faced timer problem in kernel-2.4.26 and I tried to
 > fixed with patching "arch/i386/kernel/mpparse.c" file taken from
 > patch-2.4.27.
 > ...	...	...
 > Mikael Pettersson:
 >   o i386 and x86_64 ACPI mpparse timer bug
 > ...	...	...
 > 	After booting up the system now I get OOPS. Did I applied partial patch by
 > taking only patch for mpparse.c from the whole buntch? Does it broken
 > dependency to some other functionality? I've ACPI support enabled into
 > kernel.

The effect of the bug was that the timer generated twice as
many interrupts, making the kernel's wall-clock timer twice
as fast.

There were no OOPS issues related with that patch. Therefore,
your OOPS indicates dependencies on other changes in mpparse
and/or the ACPI code. Why hack a 2.4.26 kernel in this way?
Just put a 2.4.27 or 2.4.28-rc4 in there and be done with it :-)

/Mikael
