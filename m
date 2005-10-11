Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVJKXCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVJKXCf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 19:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJKXCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 19:02:35 -0400
Received: from host-84-9-201-81.bulldogdsl.com ([84.9.201.81]:41094 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1751257AbVJKXCe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 19:02:34 -0400
Date: Wed, 12 Oct 2005 00:02:31 +0100
From: Ben Dooks <ben@fluff.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 8250_early.c passing 0 instead of NULL
Message-ID: <20051011230231.GA19085@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix sparse warning about passing `0` to 
simple_strtoul()

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8250-fix-null.patch"

--- linux-2.6.14-rc4/drivers/serial/8250_early.c	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.14-rc4-bjd1/drivers/serial/8250_early.c	2005-10-12 00:01:02.000000000 +0100
@@ -164,7 +164,7 @@ static int __init parse_options(struct e
 
 	if ((options = strchr(options, ','))) {
 		options++;
-		device->baud = simple_strtoul(options, 0, 0);
+		device->baud = simple_strtoul(options, NULL, 0);
 		length = min(strcspn(options, " "), sizeof(device->options));
 		strncpy(device->options, options, length);
 	} else {

--ew6BAiZeqk4r7MaW--
