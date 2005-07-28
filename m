Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVG1HxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVG1HxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 03:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVG1Hv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 03:51:26 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:19381 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261350AbVG1HtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 03:49:10 -0400
Message-ID: <42E88DC8.7050507@jp.fujitsu.com>
Date: Thu, 28 Jul 2005 16:48:24 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 2.6.13-rc3 0/6] failure of acpi_register_gsi() should be handled
 properly
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Current acpi_register_gsi() function has no way to indicate errors to
its callers even though acpi_register_gsi() can fail to register gsi
because of some reasons (out of memory, lack of interrupt vectors,
incorrect BIOS, and so on). As a result, caller of acpi_register_gsi()
cannot handle the case that acpi_register_gsi() fails. I think failure
of acpi_register_gsi() should be handled properly.

This series of patches changes acpi_register_gsi() to return negative
value on error, and also changes callers of acpi_register_gsi() to
handle failure of acpi_register_gsi().

Thanks,
Kenji Kaneshige

