Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVAHBiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVAHBiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 20:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVAHBiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 20:38:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:12756 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261778AbVAHBg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 20:36:27 -0500
Date: Fri, 7 Jan 2005 17:36:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AGP Oops (was Re: 2.6.10-mm2)
Message-Id: <20050107173607.1fc69878.akpm@osdl.org>
In-Reply-To: <6umzvkhfl5.fsf@zork.zork.net>
References: <20050106002240.00ac4611.akpm@osdl.org>
	<6umzvkhfl5.fsf@zork.zork.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> wrote:
>
> Got the following upon starting X (Debian sid's 4.3.0.dfsg.1-10).
> Was fine with 2.6.10-mm1.  Radeon card, VIA AGP.
> 

Did you have this?

--- 25/drivers/char/agp/generic.c~agpgart-add-bridge-assignment-missed-in-agp_allocate_memory	Thu Jan  6 15:50:18 2005
+++ 25-akpm/drivers/char/agp/generic.c	Thu Jan  6 15:50:18 2005
@@ -211,6 +211,7 @@ struct agp_memory *agp_allocate_memory(s
 		new->memory[i] = virt_to_phys(addr);
 		new->page_count++;
 	}
+       new->bridge = bridge;
 
 	flush_agp_mappings();
 
_

