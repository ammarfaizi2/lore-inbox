Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266697AbUFYKrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266697AbUFYKrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUFYKrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:47:47 -0400
Received: from cavan.codon.org.uk ([213.162.118.85]:1978 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S266697AbUFYKrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:47:46 -0400
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Date: Fri, 25 Jun 2004 11:48:25 +0100
Message-Id: <1088160505.3702.4.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: No APIC interrupts after ACPI suspend
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.0 (built Tue, 16 Mar 2004 19:40:56 +0100)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I do an S3 suspend, my machine resumes correctly (Thinkpad X40,
acpi_sleep=s3_bios passed on the command line). If I have the ioapic
enabled, however, I get no interrupts after resume. Hacking in a call to
APIC_init_uniprocessor in the resume path improves things - I get edge
triggered interrupts, but anything flagged as level triggered doesn't
work. How can I get the ioapic fully initialised on resume?
-- 
Matthew Garrett | mjg59@srcf.ucam.org

