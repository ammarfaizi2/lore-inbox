Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVB0GeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVB0GeW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 01:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVB0GeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 01:34:22 -0500
Received: from smtp818.mail.sc5.yahoo.com ([66.163.170.4]:54163 "HELO
	smtp818.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261353AbVB0GeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 01:34:16 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Frank Victor Fischer <celestar@t-online.de>
Subject: Re: ALPS touchpad not seen by 2.6.11 kernels
Date: Sun, 27 Feb 2005 01:34:12 -0500
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200502262355.13559.celestar@t-online.de>
In-Reply-To: <200502262355.13559.celestar@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502270134.13625.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 February 2005 17:55, Frank Victor Fischer wrote:
> I have had the same problem and the solution worked for me as well.
> 
> Where should I put the DSDT?
> 
> Please reply to my e-mail, as I am no linux-kernel subscriber.

Thanks for DSDT! Could you please try the follwing patch?

Andrew, if this works I'd like to see it in 2.6.11...
Vojtech, I will send you patch for PNP shortly after.
 
-- 
Dmitry


=====================================================================

Input: add more PNP IDs to i8042 driver.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


===== drivers/input/serio/i8042-x86ia64io.h 1.2 vs edited =====
--- 1.2/drivers/input/serio/i8042-x86ia64io.h	2004-10-19 05:58:22 -05:00
+++ edited/drivers/input/serio/i8042-x86ia64io.h	2005-02-27 01:27:58 -05:00
@@ -224,7 +224,7 @@
 
 static struct acpi_driver i8042_acpi_aux_driver = {
 	.name		= "i8042",
-	.ids		= "PNP0F13,SYN0801",
+	.ids		= "PNP0F03,PNP0F0B,PNP0F0E,PNP0F12,PNP0F13,SYN0801",
 	.ops		= {
 		.add		= i8042_acpi_aux_add,
 	},
