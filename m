Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUGSMWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUGSMWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 08:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUGSMWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 08:22:04 -0400
Received: from cavan.codon.org.uk ([213.162.118.85]:55773 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S265051AbUGSMWC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 08:22:02 -0400
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-Id: <1090239727.7459.10.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Jul 2004 13:22:07 +0100
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Resume failing in get_cmos_time()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.0 (built Sat, 24 Apr 2004 12:31:30 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On around 20% of ACPI resume attempts, the resume hangs during
time_resume(). I've traced this down to the get_cmos_time() call - a
printk before that appears, one afterwards doesn't. The rest of the
time, resume works correctly. Interestingly, this only seems to happen
if I use the patch from http://bugzilla.kernel.org/show_bug.cgi?id=2643
or a similar one for the IO-APIC. Does anyone have any idea why this
might result in this sort of failure mode? I'm considering just removing
the call for now and resetting the clock from userspace.
-- 
Matthew Garrett | mjg59@srcf.ucam.org

