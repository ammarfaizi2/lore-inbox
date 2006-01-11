Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWAKPmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWAKPmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 10:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWAKPmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 10:42:04 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:26505 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751482AbWAKPmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 10:42:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=f8mywTlRkSC4zYitDkLzl5HYYU6BtOUQcWQYmSdryeL63PxY6/mOk0v4UUwFe6bcf7kFTS+h3d2XFue6LN31/6baHZmub5etISo4Q7p+6I/mT5pqi9zcEqqhbEigUXQysdrfngysNR76wbAo/GZ2UWMRHNLKOKS0717AF9/driQ=
Date: Wed, 11 Jan 2006 18:59:07 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include/asm-*/bitops.h: fix more "~0UL >> size" typos
Message-ID: <20060111155907.GB8686@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"[PATCH] m68knommu: fix find_next_zero_bit in bitops.h" fixed a typo in
m68knommu implementation of find_next_zero_bit().

grep(1) shows that cris, frv, h8300, v850 are also affected.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-cris/bitops.h  |    2 +-
 include/asm-frv/bitops.h   |    2 +-
 include/asm-h8300/bitops.h |    2 +-
 include/asm-v850/bitops.h  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/include/asm-cris/bitops.h
+++ b/include/asm-cris/bitops.h
@@ -290,7 +290,7 @@ static inline int find_next_zero_bit (co
 	tmp = *p;
 	
  found_first:
-	tmp |= ~0UL >> size;
+	tmp |= ~0UL << size;
  found_middle:
 	return result + ffz(tmp);
 }
--- a/include/asm-frv/bitops.h
+++ b/include/asm-frv/bitops.h
@@ -209,7 +209,7 @@ static inline int find_next_zero_bit(con
 	tmp = *p;
 
 found_first:
-	tmp |= ~0UL >> size;
+	tmp |= ~0UL << size;
 found_middle:
 	return result + ffz(tmp);
 }
--- a/include/asm-h8300/bitops.h
+++ b/include/asm-h8300/bitops.h
@@ -227,7 +227,7 @@ static __inline__ int find_next_zero_bit
 	tmp = *p;
 
 found_first:
-	tmp |= ~0UL >> size;
+	tmp |= ~0UL << size;
 found_middle:
 	return result + ffz(tmp);
 }
--- a/include/asm-v850/bitops.h
+++ b/include/asm-v850/bitops.h
@@ -188,7 +188,7 @@ static inline int find_next_zero_bit(con
 	tmp = *p;
 
  found_first:
-	tmp |= ~0UL >> size;
+	tmp |= ~0UL << size;
  found_middle:
 	return result + ffz (tmp);
 }

