Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263521AbUCTUA1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 15:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUCTUA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 15:00:27 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:64778 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263521AbUCTUAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 15:00:25 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.5-rc2] LSB compliance fix in mprotect
Date: Sat, 20 Mar 2004 20:59:19 +0100
User-Agent: KMail/1.6.1
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Working Overloaded Linux Kernel
Message-Id: <200403202059.19456@WOLK>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XKKXAPvydI9pQ9Y"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_XKKXAPvydI9pQ9Y
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Linus, Andrew,

http://linux.bkbits.net:8080/linux-2.4/diffs/mm/mprotect.c@1.5?nav=index.html|
src/|src/mm|hist/mm/mprotect.c

2.4 patch from Adrian.

Please apply.

ciao, Marc

--Boundary-00=_XKKXAPvydI9pQ9Y
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="mprotect-posix-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mprotect-posix-fix.patch"

# mm/mprotect.c |    2 +-
# 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nru a/mm/mprotect.c b/mm/mprotect.c
--- a/mm/mprotect.c	Sun Mar  3 10:00:38 2002
+++ b/mm/mprotect.c	Thu Sep  4 02:14:56 2003
@@ -237,7 +237,7 @@
 	len = PAGE_ALIGN(len);
 	end = start + len;
 	if (end < start)
-		return -EINVAL;
+		return -ENOMEM;
 	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM))
 		return -EINVAL;
 	if (end == start)

--Boundary-00=_XKKXAPvydI9pQ9Y--

