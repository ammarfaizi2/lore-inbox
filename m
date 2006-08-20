Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWHTOs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWHTOs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 10:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWHTOs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 10:48:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:7606 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750813AbWHTOsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 10:48:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=GfPSmXWFiF0lTduJXpBZXF7sltLbZXaXHQk2Fbi4/m/XFfP0Yah8v2DnOZIAcPvQ9CUR0+6IN5U3u0l6Ukrud7IKe1H+QrMCCMLX+HzELM+i5ySK3F0jyeEbqW3cOqyLKKRvb3F4N3Ga+leCQWk+VXN/yFLPvPG6Kif1uLShX4E=
Date: Sun, 20 Aug 2006 18:48:13 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
Subject: [PATCH -mm] agp.h: constify struct agp_bridge_data::version
Message-ID: <20060820144813.GA5079@martell.zuzino.mipt.ru>
References: <20060813012454.f1d52189.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/agp/backend.c: In function `agp_backend_initialize':
drivers/char/agp/backend.c:141: warning: assignment discards qualifiers from pointer target type

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/agp/agp.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/agp/agp.h
+++ b/drivers/char/agp/agp.h
@@ -117,7 +117,7 @@ struct agp_bridge_driver {
 };
 
 struct agp_bridge_data {
-	struct agp_version *version;
+	const struct agp_version *version;
 	struct agp_bridge_driver *driver;
 	struct vm_operations_struct *vm_ops;
 	void *previous_size;

