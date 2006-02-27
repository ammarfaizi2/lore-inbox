Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751610AbWB0Gzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWB0Gzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWB0Gzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:55:42 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:45077 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751610AbWB0Gzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:55:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=agNW3QczM4XXgmowpVbUEvOFAsIzmdtMHukUnmUPZeoeW97kIDhmhlm9TnCH29dgVNVkKbGcN92tJNT3gtolYlXucD7nHNz3Lh+LhOgwFbhAqZFDA2Zf6Kl3Gn+8RDDbSiYKMl/FkZZhxRC+hT59A0wnJLg0mNLvMKVhdJcseBw=
Date: Mon, 27 Feb 2006 09:55:38 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] video1394: fix "return E;" typo
Message-ID: <20060227065538.GA10862@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ieee1394/video1394.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ieee1394/video1394.c
+++ b/drivers/ieee1394/video1394.c
@@ -744,7 +744,7 @@ static int __video1394_ioctl(struct file
 			if (i == ISO_CHANNELS) {
 			    PRINT(KERN_ERR, ohci->host->id, 
 				  "No free channel found");
-			    return EAGAIN;
+			    return -EAGAIN;
 			}
 			if (!(ohci->ISO_channel_usage & mask)) {
 			    v.channel = i;

