Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264462AbTIJDnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 23:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbTIJDnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 23:43:25 -0400
Received: from beta.galatali.com ([216.40.241.205]:5785 "EHLO
	beta.galatali.com") by vger.kernel.org with ESMTP id S264462AbTIJDnY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 23:43:24 -0400
Subject: Why is the Compaq W8000 ACPI blacklisted?
From: Tugrul Galatali <tugrul@galatali.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1063165275.1806.16.camel@winnebago>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 23:42:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Since test4, I've had

Compaq Workstation W8000 detected: force use of acpi=ht

	which leads to

ACPI: Interpreter disabled.

	and that to annoying things like spinning down my IDE drive, which it
isn't configured to do and doesn't happen in test3, and not powering off
on shutdown.

	I see the entry doing this (./arch/i386/kernel/dmi_scan.c:922)

        { force_acpi_ht, "Compaq Workstation W8000", {
                        MATCH(DMI_SYS_VENDOR, "Compaq"),
                        MATCH(DMI_PRODUCT_NAME, "Workstation W8000"),
                        NO_MATCH, NO_MATCH }},

	introduced in test4. But why? Are there problems with more advanced
features like sleep?

	acpi=force on test5 returns me to the functionality I had in test3.

	Tugrul Galatali


