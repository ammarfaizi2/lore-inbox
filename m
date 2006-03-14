Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWCNU6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWCNU6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWCNU6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:58:09 -0500
Received: from smtp1.xs4all.be ([195.144.64.135]:2496 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S932226AbWCNU6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:58:08 -0500
Date: Tue, 14 Mar 2006 21:57:58 +0100
From: Frank Gevaerts <frank@gevaerts.be>
To: rlove@rlove.org, linux-kernel@vger.kernel.org
Subject: patch : hdaps on Thinkpad R52
Message-ID: <20060314205758.GA9229@gevaerts.be>
Mail-Followup-To: rlove@rlove.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
X-flash-is-evil: do not use it
X-virus: If this mail contains a virus, feel free to send one back
User-Agent: Mutt/1.5.9i
X-gevaerts-MailScanner: Found to be clean
X-MailScanner-From: fg@gevaerts.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I had to add a new entry to the hdaps_whitelist table in hdaps.c to get
my Thinkpad R52 recognized. Patch is attached

Frank


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hdaps-r52.patch"

diff -ur linux-2.6.16-rc4/drivers/hwmon/hdaps.c linux-2.6.16-rc4-fg/drivers/hwmon/hdaps.c
--- linux-2.6.16-rc4/drivers/hwmon/hdaps.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc4-fg/drivers/hwmon/hdaps.c	2006-02-24 13:25:53.000000000 +0100
@@ -515,6 +515,7 @@
 
 	/* Note that DMI_MATCH(...,"ThinkPad T42") will match "ThinkPad T42p" */
 	struct dmi_system_id hdaps_whitelist[] = {
+		HDAPS_DMI_MATCH_NORMAL("ThinkPad H"),
 		HDAPS_DMI_MATCH_INVERT("ThinkPad R50p"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad R50"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad R51"),

--pWyiEgJYm5f9v55/--
