Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUHAA5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUHAA5N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUHAA5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:57:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:6294 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264299AbUHAA5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:57:03 -0400
Date: Sat, 31 Jul 2004 17:55:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg Howard <ghoward@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix system controller communication driver
Message-Id: <20040731175518.407425bc.akpm@osdl.org>
In-Reply-To: <Pine.SGI.4.58.0407301640510.4902@gallifrey.americas.sgi.com>
References: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com>
	<20040728085737.26e0bfd2.akpm@osdl.org>
	<Pine.SGI.4.58.0407301640510.4902@gallifrey.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Howard <ghoward@sgi.com> wrote:
>
>  Here's a cleaned-up version of altix-system-controller-driver.patch.

Breaks the build for all other architectures:

Is this right?

--- 25/drivers/char/Kconfig~snsc-build-fix	2004-07-31 17:53:52.818565424 -0700
+++ 25-akpm/drivers/char/Kconfig	2004-07-31 17:54:39.658444680 -0700
@@ -426,6 +426,7 @@ config A2232
 
 config SGI_SNSC
 	bool "SGI Altix system controller communication support"
+	depends on CONFIG_IA64_SGI_SN2
 	help
 	  If you have an SGI Altix and you want to enable system
 	  controller communication from user space (you want this!),
_

