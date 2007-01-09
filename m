Return-Path: <linux-kernel-owner+w=401wt.eu-S1750747AbXAIAVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbXAIAVV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbXAIAVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:21:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:2002 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbXAIAVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:21:20 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,161,1167638400"; 
   d="scan'208"; a="185916459:sNHT335124482"
Date: Mon, 8 Jan 2007 16:21:01 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@jikos.cz,
       akpm@osdl.org
Subject: [patch 0/2] Bay driver bug fixes
Message-Id: <20070108162101.a32772bf.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,
Here are 2 patches to fix a couple bugs with the bay driver.  The first
addresses the problem that jikos reported with the bay driver failing
at load due to BUG: at lib/kref.c:32 kref_get().  Since the bay driver
is also a platform driver, I found that when it is compiled into the 
kernel (built in) there is a problem with it being simultaneously an
acpi driver as well as a platform driver.  Since it wasn't really useful
for the bay driver to be an acpi driver, I removed that code.  The second
patch addresses the build issue with bay when dock is not built by making
the bay driver depend on the dock driver.  

Thanks,
Kristen

--
