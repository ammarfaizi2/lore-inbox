Return-Path: <linux-kernel-owner+w=401wt.eu-S1752803AbWLXVTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbWLXVTa (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 16:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbWLXVTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 16:19:30 -0500
Received: from postfix1-g20.free.fr ([212.27.60.42]:54860 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbWLXVT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 16:19:29 -0500
Message-ID: <458EEEC6.4000406@yahoo.fr>
Date: Sun, 24 Dec 2006 22:19:02 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ismail Donmez <ismail@pardus.org.tr>
CC: linux-kernel@vger.kernel.org
Subject: Re: ACPI EC warnings
References: <200612242247.06989.ismail@pardus.org.tr> <3d8471ca0612241302j5d4a92cdi84eec81e0739aa2@mail.gmail.com> <200612242305.59729.ismail@pardus.org.tr>
In-Reply-To: <200612242305.59729.ismail@pardus.org.tr>
Content-Type: multipart/mixed;
 boundary="------------070405080802000906090704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070405080802000906090704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> Patch looks nice,
But LKML didn't like gmail's HTML so here is it again. Hopefully this 
one will pass.

> btw do you notice any skippy behaviour? i.e sound skips when 
> I get this warning

No, in my case I just get the message: ACPI: EC: evaluating _Q20
> or something else is broken and I blame ACPI because its 
> flooding dmesg =)
>   
I happen to have at the moment some other debugging printk, flooding
my logs, and sound doesn't skip either :-) Asus V6VA - Pentium-M 2GHz here.

-- 
Guillaume


--------------070405080802000906090704
Content-Type: text/x-patch;
 name="ACPI.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ACPI.diff"

diff -r ef50bfb54157 drivers/acpi/ec.c
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -424,7 +424,7 @@ static void acpi_ec_gpe_query(void *ec_c
 
 	snprintf(object_name, 8, "_Q%2.2X", value);
 
-	printk(KERN_INFO PREFIX "evaluating %s\n", object_name);
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluating %s", object_name));
 
 	acpi_evaluate_object(ec->handle, object_name, NULL, NULL);
 }


--------------070405080802000906090704--
