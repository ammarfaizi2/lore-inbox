Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbUKWBMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbUKWBMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 20:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUKWBLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 20:11:39 -0500
Received: from fmr13.intel.com ([192.55.52.67]:56290 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261242AbUKWBIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 20:08:47 -0500
Subject: why use ACPI (Re: 2.6.10-rc2 doesn't boot (if no floppy device))
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041123004619.GQ19419@stusta.de>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de>
	 <1101148138.20008.6.camel@d845pe>  <20041123004619.GQ19419@stusta.de>
Content-Type: text/plain
Organization: 
Message-Id: <1101172056.20006.153.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Nov 2004 20:07:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 19:46, Adrian Bunk wrote:

> Not needed "pressing the power button when you halt the system" is the
> "killer application" for using ACPI for me...

Yes, thats certainly one that people notice right away.  Laptops have
had soft poweroff with APM for a while, but desktops and servers never
adopted APM, so soft-power-off is generally a new feature with ACPI for
them.

Enabling IOAPIC is one that a lot of people like, because it results in
less interrupt sharing and better performance than PIC mode.  But if you
don't load your system much you may not notice any difference.

Next people tend to notice fan speed, because they can hear it.
If you load processor and thermal, you'll probably see some
/proc/acpi/thermal/thermal_zone/*/temperature and you'll
probably find that it stays lower if you keep processor
loaded versus when you do not.

This is usually because of power-saving c-csates in idle,
which you can observe in /proc/acpi/processor/*/power
and the higher the C-state, the more power you save.

Also, CPUFREQ usually often on ACPI, and that can save
power even when the system is not idle, and this results
in lower temperatures and hopefully slower fan speeds.

cheers,
-Len


