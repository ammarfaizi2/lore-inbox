Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVILNs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVILNs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbVILNs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:48:59 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:55209 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750838AbVILNs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:48:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=FZt4rHiesAkPK+XCS7uRsJzPgRkIjgzQh1/McR1K1felEKj3G+8H+wL4DpRBGbgobiIJRgEmrOfdvqzOVKOVmuyvRem3CPOZ4sLW2XeM0coX6wuCYPxR+PxZW5qarmwxMXTWDWcAkOnH/i1DDJPi0yIEOqVeuaaWzbSN17BCBUk=
Date: Mon, 12 Sep 2005 17:58:47 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/base/class.c: fix swapped memset() arguments
Message-ID: <20050912135847.GA9673@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/base/class.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-vanilla/drivers/base/class.c
+++ linux-memset/drivers/base/class.c
@@ -506,7 +506,7 @@ int class_device_add(struct class_device
 			kobject_del(&class_dev->kobj);
 			goto register_done;
 		}
-		memset(attr, sizeof(*attr), 0x00);
+		memset(attr, 0x00, sizeof(*attr));
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
 		attr->attr.owner = parent->owner;

