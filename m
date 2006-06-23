Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWFWPjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWFWPjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWFWPjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:39:07 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:13749 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751473AbWFWPjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:39:05 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net, sergio@sergiomb.no-ip.org
Subject: Re: [linux-usb-devel] who I do know if a interrupt is ioapic_edge_type or ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:	2.6.17-rc6-mm2 - USB issues]]
Date: Fri, 23 Jun 2006 08:31:04 -0700
User-Agent: KMail/1.7.1
Cc: Johny <kernel@agotnes.com>, Andrew Morton <akpm@osdl.org>, vsu@altlinux.ru,
       Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
       linux-usb-users@lists.sourceforge.net, linux-acpi@vger.kernel.org,
       stern@rowland.harvard.edu
References: <44953B4B.9040108@agotnes.com> <4499245C.8040207@agotnes.com> <1150936606.2855.21.camel@localhost.portugal>
In-Reply-To: <1150936606.2855.21.camel@localhost.portugal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606230831.05832.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't quite the same as "how to handle the VIA quirks correctly",
but it does seem like the IRQ API should probably have a call to get
the IRQ trigger mode, just like it has ways to set it.  I've seen
drivers that need to try multiple trigger modes before they find one
that will work on the target platform.

The actual details of _how_ that trigger mode is set -- APIC, PIC and
so on for x86; or other IRQ controllers on other hardware -- should
not matter to drivers, since they're platform-specific.  The quirk
handling code is platform-specific though, and might care.

- Dave
