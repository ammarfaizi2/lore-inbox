Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbVIUR0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVIUR0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVIUR0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:26:48 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:30411 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751293AbVIUR0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:26:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=O9f5DZmHWvBvTUN46Ie5EhKEPBqc76Eo/JJ8u+ScW8NwdjC3hkzNyQpOZxoNrgbAcHxjW0ENhkeyenUKG7spJcjW1T0OqMwW28QJHQ7lgY8QoImxD7TL/CxSbxO6xfJG54vvygjaWoBIQKcFKk0pmbeq/Tyxgg+ZS47RQSvxGOA=
Date: Wed, 21 Sep 2005 21:37:24 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ver_linux: don't print reiser4progs version if none found
Message-ID: <20050921173724.GA21734@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/ver_linux |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -42,7 +42,7 @@ fsck.jfs -V 2>&1 | grep version | sed 's
 reiserfsck -V 2>&1 | grep reiserfsck | awk \
 'NR==1{print "reiserfsprogs         ", $2}'
 
-fsck.reiser4 -V 2>&1 | grep fsck.reiser4 | awk \
+fsck.reiser4 -V 2>&1 | grep ^fsck.reiser4 | awk \
 'NR==1{print "reiser4progs          ", $2}'
 
 xfs_db -V 2>&1 | grep version | awk \

