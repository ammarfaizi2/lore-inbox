Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266360AbSKGFX4>; Thu, 7 Nov 2002 00:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266364AbSKGFX4>; Thu, 7 Nov 2002 00:23:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12047 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266360AbSKGFXz>; Thu, 7 Nov 2002 00:23:55 -0500
Message-ID: <3DC9FA67.2000303@zytor.com>
Date: Wed, 06 Nov 2002 21:30:15 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: 2.4.20-rc1: oops in drivers/acpi/namespace/nswalk.c (with patch)
Content-Type: multipart/mixed;
 boundary="------------000401030706080903000506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000401030706080903000506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have one machine which has been reliably oopsing in 
drivers/acpi/namespace/nswalk.c -- this patch makes it work, but I have 
no idea why.  Either way, I thought someone would probably want to look 
at it.

	-hpa

--------------000401030706080903000506
Content-Type: text/plain;
 name="nswalk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nswalk.patch"

--- drivers/acpi/namespace/nswalk.c~	Wed Oct 24 14:06:22 2001
+++ drivers/acpi/namespace/nswalk.c	Wed Nov  6 21:13:37 2002
@@ -63,6 +63,8 @@
 
 	FUNCTION_ENTRY ();
 
+	if (!parent_node)
+		return NULL;	/* Uhm... */
 
 	if (!child_node) {
 		/* It's really the parent's _scope_ that we want */

--------------000401030706080903000506--

