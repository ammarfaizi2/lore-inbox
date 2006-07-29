Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422695AbWG2ISt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbWG2ISt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 04:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbWG2ISs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 04:18:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:45360 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422695AbWG2ISs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 04:18:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Lg72ZdZeK8Iehrml7YlEgsXqEhUXPnUeFt8vVpa/1cvk7S+6YtAgcBDOXggQ74+4V7kKq8WlP0S9o+90tdsbw92D92CF8eSc3znQhXtvMA0UT2VBluy4sa/D7/cqatC9p54F/+Mg++uC5IGiJWzSIoul1ixJ/L8P7H5MexLPSw4=
Date: Sat, 29 Jul 2006 12:18:45 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 1/2] headers_check: clarify error message
Message-ID: <20060729081845.GC6843@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/hdrcheck.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/hdrcheck.sh
+++ b/scripts/hdrcheck.sh
@@ -2,7 +2,7 @@ #!/bin/sh
 
 for FILE in `grep '^#include <' $2 | cut -f2 -d\< | cut -f1 -d\> | egrep ^linux\|^asm` ; do
     if [ ! -r $1/$FILE ]; then
-	echo $2 requires $FILE, which does not exist
+	echo $2 requires $FILE, which does not exist in exported headers
 	exit 1
     fi
 done

