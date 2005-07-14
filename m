Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263030AbVGNOy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbVGNOy6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 10:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbVGNOy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 10:54:58 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:56470 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263030AbVGNOy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 10:54:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MPwyEPl5WiLlu3BiWdczSmJACd5+sAGgPzM2BHLYstqcFiiWV1wkvJk5XtILgSpgfA5kXNxG+UO5YLTqQvklUMEYSSOEfAFgOv8Ckzxdi5ssBLu/4BOxBML7WFz4nSKcBzl770NwLCEDPu8OFfuGaATpAG7xo0lccncGM2bW2oA=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] visws: reexport pm_power_off
Date: Thu, 14 Jul 2005 19:01:59 +0400
User-Agent: KMail/1.8.1
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <1121261886.5049.7.camel@mulgrave>
In-Reply-To: <1121261886.5049.7.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507141901.59358.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 July 2005 17:38, James Bottomley wrote:
> [PATCH] Remove i386_ksyms.c, almost
> 
> made files like smp.c do their own EXPORT_SYMBOLS.  This means that all
> subarchitectures that override these symbols now have to do the exports
> themselves.  This patch adds the exports for voyager (which is the most
> affected since it has a separate smp harness).  However, someone should
> audit all the other subarchitectures to see if any others got broken.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/i386/mach-visws/reboot.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-vanilla/arch/i386/mach-visws/reboot.c	2005-07-13 19:45:59.000000000 +0400
+++ linux-visws/arch/i386/mach-visws/reboot.c	2005-07-14 18:53:23.000000000 +0400
@@ -7,6 +7,7 @@
 #include "piix4.h"
 
 void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
 
 void machine_restart(char * __unused)
 {
