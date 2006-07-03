Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWGCUoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWGCUoF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWGCUoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:44:05 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:57011 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751154AbWGCUoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:44:03 -0400
Message-ID: <44A981F5.7000708@oracle.com>
Date: Mon, 03 Jul 2006 13:45:41 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
CC: "Brown, Len" <len.brown@intel.com>, akpm <akpm@osdl.org>
Subject: [UBUNTU PATCH: acpi] Do not abort method execution if asked to release
 not acquired mutex
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Short <chuck@maggie>

[UBUNTU: acpi] Do not abort method execution if asked to release not acquired mutex.

See http://bugme.osdl.org/show_bug.cgi?id=6687
Closes: #50088

patch location:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=202ddb5b6498af53e110f78edd41a217587c1ffb

Signed-off-by: Chuck Short <zulcss@gmail.com>
Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---
 drivers/acpi/executer/exmutex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-g21.orig/drivers/acpi/executer/exmutex.c
+++ linux-2617-g21/drivers/acpi/executer/exmutex.c
@@ -246,7 +246,7 @@ acpi_ex_release_mutex(union acpi_operand
 		ACPI_ERROR((AE_INFO,
 			    "Cannot release Mutex [%4.4s], not acquired",
 			    acpi_ut_get_node_name(obj_desc->mutex.node)));
-		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	/* Sanity check -- we must have a valid thread ID */



