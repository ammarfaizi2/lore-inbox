Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265634AbUA0WJC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265630AbUA0WGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:06:40 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:18606 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S265631AbUA0WG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:06:26 -0500
To: marcelo.tosatti@cyclades.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4 ACPI dispatcher/dsmthdat.c warning fix
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 27 Jan 2004 22:54:33 +0100
Message-ID: <m3brop5a7a.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

I think this is what the author meant, i.e. we don't need to substitute
obj_desc = new_obj_desc there as it is done later in the file.

This patch doesn't change kernel behaviour, it only eliminates the
warning message.

Please apply to 2.4 kernel tree. Thanks.
-- 
Krzysztof Halasa, B*FH

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=dsmthdat-2.4.25pre7.patch

--- linux-2.4.orig/drivers/acpi/dispatcher/dsmthdat.c	2004-01-27 21:22:26.000000000 +0100
+++ linux-2.4/drivers/acpi/dispatcher/dsmthdat.c	2004-01-27 22:41:04.000000000 +0100
@@ -601,7 +601,6 @@
 	new_obj_desc = obj_desc;
 	if (obj_desc->common.reference_count > 1) {
 		status = acpi_ut_copy_iobject_to_iobject (obj_desc, &new_obj_desc, walk_state);
-		new_obj_desc;
 		if (ACPI_FAILURE (status)) {
 			return_ACPI_STATUS (status);
 		}

--=-=-=--
