Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVBNUVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVBNUVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 15:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVBNUVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 15:21:41 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:63141 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261557AbVBNUVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 15:21:34 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: acpi-devel@lists.debian.org
Cc: linux-kernel@vger.kernel.org
Date: Mon, 14 Feb 2005 20:20:35 +0000
Message-Id: <1108412435.4085.112.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: ACPI and hotplug module loading
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI modules provide the name of the device that they want to bind to in
the .ids section of the acpi_driver structure. Currently this
information isn't made available in module.aliases - nor does the
information from the DSDT seem to make its way into /sys anywhere. If
these two issues were fixed, it would be possible for hotplug to
autoload acpi modules on boot.

The first of these is fairly easy to fix - it just requires a macro to
populate a MODULE_ALIAS table during module building. The second sounds
more awkward. Is this a desirable goal, and if so what's the best way of
approaching it?
-- 
Matthew Garrett | mjg59@srcf.ucam.org

