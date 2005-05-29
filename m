Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVE2IOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVE2IOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 04:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVE2IOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 04:14:25 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:46064 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261278AbVE2IOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 04:14:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rVqC5uuVwFu8qVcnaBzIriX/4YeDdyUqYxSLy/SmdFG1MTYGbs3cuVSdBvEpPnOrbvThz/iFsN1o9qbHbhFim9OjKhJ00X7NIpkfbIdFofiKRTXtCU1OqPioQgHW2wdY96Jr3X3EUouZfz1BQeeFyTDqlhve0qd3dmaG9qFqF4c=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.12-rc5-git3 ia64 acpi build breakage.
Date: Sun, 29 May 2005 12:18:55 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050529000121.GA15681@redhat.com>
In-Reply-To: <20050529000121.GA15681@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505291218.55810.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 May 2005 04:01, Dave Jones wrote:
> In file included from drivers/firmware/pcdp.c:18:
> drivers/firmware/pcdp.h:48: error: field 'addr' has incomplete type
> drivers/firmware/pcdp.c: In function 'setup_serial_console':
> drivers/firmware/pcdp.c:27: error: 'ACPI_ADR_SPACE_SYSTEM_MEMORY' undeclared (first use in this function)

This _should_ fix it.

--- linux-vanilla/include/linux/acpi.h	2005-05-28 02:59:59.000000000 +0400
+++ linux-8250/include/linux/acpi.h	2005-05-28 03:39:25.000000000 +0400
@@ -25,6 +25,8 @@
 #ifndef _LINUX_ACPI_H
 #define _LINUX_ACPI_H
 
+#include <linux/config.h>
+
 #ifdef	CONFIG_ACPI
 
 #ifndef _LINUX
