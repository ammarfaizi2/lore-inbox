Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268079AbUJGVk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268079AbUJGVk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUJGVio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:38:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:11143 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269830AbUJGVaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:30:22 -0400
Date: Thu, 7 Oct 2004 14:33:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: jschopp@austin.ibm.com
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.9-rc3-mm3
Message-Id: <20041007143359.6f11a398.akpm@osdl.org>
In-Reply-To: <4165AD8B.9020207@austin.ibm.com>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<4165AD8B.9020207@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Schopp <jschopp@austin.ibm.com> wrote:
>
> ppc64 defconfig doesn't compile for me.
> 
> drivers/video/aty/radeon_monitor.c: In function `radeon_parse_montype_prop':
> drivers/video/aty/radeon_monitor.c:77: error: parse error before "else"

--- 25/drivers/video/aty/radeon_monitor.c~radeonfb-fix-warnings-about-uninitialized-variables-fix	Thu Oct  7 14:32:40 2004
+++ 25-akpm/drivers/video/aty/radeon_monitor.c	Thu Oct  7 14:32:59 2004
@@ -74,8 +74,7 @@ static int __devinit radeon_parse_montyp
 			printk(KERN_WARNING "radeonfb: Unknown OF display-type: %s\n",
 			       pmt);
 		return MT_NONE;
-	} else
-		return MT_NONE;
+	}
 
 	for (i = 0; propnames[i] != NULL; ++i) {
 		pedid = (u8 *)get_property(dp, propnames[i], NULL);
_

