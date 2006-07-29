Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422698AbWG2IWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422698AbWG2IWw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 04:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422700AbWG2IWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 04:22:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:41016 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422698AbWG2IWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 04:22:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=sq9Lh1PFHxPdafXmZSD+4oPnYxBpjY88GwZNo8gIFcZokH71cEewFD7+0mpvWzxu9ZnRo6oBw0fdOlXg9hnQVY07TGZCx/U2DafLOfzlyU6WXU4PqTXzSeo21104HgxovuBjz+22151+FvGsTbt8kMvzMuuTSPa/UVoqDypStWU=
Date: Sat, 29 Jul 2006 12:22:49 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 2/2] headers_check: fix #include regexp
Message-ID: <20060729082249.GD6843@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note it's [SPACE TAB]*

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/hdrcheck.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/hdrcheck.sh
+++ b/scripts/hdrcheck.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-for FILE in `grep '^#include <' $2 | cut -f2 -d\< | cut -f1 -d\> | egrep ^linux\|^asm` ; do
+for FILE in `grep '^[ 	]*#[ 	]*include[ 	]*<' $2 | cut -f2 -d\< | cut -f1 -d\> | egrep ^linux\|^asm` ; do
     if [ ! -r $1/$FILE ]; then
 	echo $2 requires $FILE, which does not exist in exported headers
 	exit 1

