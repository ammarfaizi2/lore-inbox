Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWF2UxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWF2UxD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWF2UxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:53:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46298 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932487AbWF2Uw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:52:59 -0400
Date: Thu, 29 Jun 2006 16:52:53 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: fix implicit declaration on cell.
Message-ID: <20060629205253.GA22153@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Only fails with -Werror-implicit-function-declaration, but 
 it should still be fixed).

arch/powerpc/platforms/cell/setup.c:145: error: implicit declaration of function 'udbg_init_rtas_console'

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/arch/powerpc/platforms/cell/setup.c~	2006-06-29 16:50:23.000000000 -0400
+++ linux-2.6.17.noarch/arch/powerpc/platforms/cell/setup.c	2006-06-29 16:51:07.000000000 -0400
@@ -50,6 +50,7 @@
 #include <asm/irq.h>
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
+#include <asm/udbg.h>
 
 #include "interrupt.h"
 #include "iommu.h"

-- 
http://www.codemonkey.org.uk
