Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVAFUfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVAFUfT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbVAFUca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:32:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28087 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263014AbVAFUaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:30:07 -0500
Message-ID: <41DD87C0.4C45ECC8@sgi.com>
Date: Thu, 06 Jan 2005 10:47:28 -0800
From: Mike Werner <werner@sgi.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; IRIX64 6.5-ALPHA-1289606320 IP35)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you apply this and see if it helps you.

diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c        2005-01-06 09:26:31 -08:00
+++ b/drivers/char/agp/generic.c        2005-01-06 09:26:31 -08:00
@@ -211,6 +211,7 @@
                new->memory[i] = virt_to_phys(addr);
                new->page_count++;
        }
+       new->bridge = bridge;
 
        flush_agp_mappings();
