Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937184AbWLDWut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937184AbWLDWut (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 17:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937442AbWLDWut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 17:50:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:43789 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937184AbWLDWus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 17:50:48 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,494,1157353200"; 
   d="scan'208"; a="172859383:sNHT4548410720"
Date: Mon, 4 Dec 2006 14:49:30 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [patch 0/3] Dock patches
Message-Id: <20061204144930.ee923959.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,
Here are a set of patches for the dock station driver (drivers/acpi/dock).
One makes the dock station driver also a platform driver.  The second
adds sysfs entries which will be created under /sys/devices/platform/dock.0
to allow the user to read the status of the dock station (1 for docked, 0
undocked) and to initiate an undock request via software by writing to
the "undock" entry.  The third patch fixes a bug that would prevent
acpiphp from loading if the dock station was not able to load (on systems
with no _DCK in the dsdt).

Thanks,
Kristen

--
