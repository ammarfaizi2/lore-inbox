Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVAVWbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVAVWbC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 17:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVAVWbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 17:31:02 -0500
Received: from spoolo2.tiscali.be ([62.235.13.173]:24198 "EHLO
	spoolo2.tiscali.be") by vger.kernel.org with ESMTP id S262760AbVAVWa5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 17:30:57 -0500
Message-ID: <41F2D41F.8090407@tiscali.be>
Date: Sat, 22 Jan 2005 22:30:55 +0000
From: Joel Soete <soete.joel@tiscali.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, clameter@sgi.com
Subject: RE: A scrub daemon (prezeroing)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

In this part of your patch:
[...]
Index: linux-2.6.10/include/linux/gfp.h
===================================================================
--- linux-2.6.10.orig/include/linux/gfp.h	2005-01-21 10:43:59.000000000 -0800
+++ linux-2.6.10/include/linux/gfp.h	2005-01-21 11:56:07.000000000 -0800
@@ -131,4 +131,5 @@ extern void FASTCALL(free_cold_page(stru

  void page_alloc_init(void);

+void prep_zero_page(struct page *, unsigned int order);
  #endif /* __LINUX_GFP_H */
-
imoh would be better:
+void prep_zero_page(struct page *page, unsigned int order, unsigned int gfp_flags);

hth,
	Joel

