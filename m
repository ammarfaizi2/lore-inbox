Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTELOgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTELOgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:36:21 -0400
Received: from poup.poupinou.org ([195.101.94.96]:11033 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S262143AbTELOgT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:36:19 -0400
Date: Mon, 12 May 2003 16:48:56 +0200
To: acpi-devel@lists.sourceforge.net
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] TRIVIAL allow ME OS in os_acpi_name override.
Message-ID: <20030512144856.GF19475@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OS Windows ME override for os_acpi_name need character ':' to be
included.

Please apply.

--- linux/drivers/acpi/osl.c	2003/05/09 13:57:41	1.1
+++ linux/drivers/acpi/osl.c	2003/05/12 14:41:42
@@ -999,7 +999,7 @@
 		return 0;
 
 	for (; count-- && str && *str; str++) {
-		if (isalnum(*str) || *str == ' ')
+		if (isalnum(*str) || *str == ' ' || *str == ':')
 			*p++ = *str;
 		else if (*str == '\'' || *str == '"')
 			continue;

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
