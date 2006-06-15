Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031132AbWFOTAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031132AbWFOTAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 15:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031133AbWFOTAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 15:00:21 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:35007 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1031132AbWFOTAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 15:00:19 -0400
Message-ID: <4491BC6B.5000704@oracle.com>
Date: Thu, 15 Jun 2006 13:00:43 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>, len.brown@intel.com
Subject: [Ubuntu PATCH] acpi: Add IBM R60E laptop to proc-idle blacklist
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[UBUNTU:acpi] Add IBM R60E laptop to proc-idle blacklist.

Reference: https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/38228
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commit;h=ce5e62bc55056049d192c422b6032f6a406e0ba2

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---
 drivers/acpi/processor_idle.c |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2617-rc6g7.orig/drivers/acpi/processor_idle.c
+++ linux-2617-rc6g7/drivers/acpi/processor_idle.c
@@ -142,6 +142,9 @@ static struct dmi_system_id __cpuinitdat
 	{ set_max_cstate, "IBM ThinkPad R40e", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION, "1SET70WW") }, (void*)1},
 	{ set_max_cstate, "Medion 41700", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"R01-A1J")}, (void *)1},



