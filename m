Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVBIQGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVBIQGA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 11:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVBIQGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 11:06:00 -0500
Received: from cantor.suse.de ([195.135.220.2]:64385 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261840AbVBIQFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 11:05:55 -0500
Message-ID: <420A34E1.2020608@suse.de>
Date: Wed, 09 Feb 2005 17:05:53 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: aurelien francillon <aurel@naurel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG]  linux-2.6.11-rc3 probably in ACPI  battery procfs ...
References: <4207557B.2090500@naurel.org>
In-Reply-To: <4207557B.2090500@naurel.org>
Content-Type: multipart/mixed;
 boundary="------------080202030507080406040101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080202030507080406040101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

aurelien francillon wrote:

> CONFIG_ACPI_DEBUG=y

This one is also bad for you. If you unset this, it will even run fast
even without the object cache (i'm recompiling right now with object
cache _and_ unset debug to see what i can gain from this :-)
Maybe a patch like the attached one for the Kconfig help text is apropriate.

Good luck

    Stefan

--------------080202030507080406040101
Content-Type: text/plain;
 name="acpi-debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-debug.diff"

--- linux/drivers/acpi/Kconfig~	2005-02-09 17:02:27.000000000 +0100
+++ linux/drivers/acpi/Kconfig	2005-02-09 17:03:47.000000000 +0100
@@ -276,7 +276,8 @@
 	help
 	  The ACPI driver can optionally report errors with a great deal
 	  of verbosity. Saying Y enables these statements. This will increase
-	  your kernel size by around 50K.
+	  your kernel size by around 50K. It may also severely impact the
+	  performance of the system.
 
 config ACPI_BUS
 	bool

--------------080202030507080406040101--
