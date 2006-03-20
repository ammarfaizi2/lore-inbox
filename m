Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWCTNhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWCTNhk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWCTNhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:37:40 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:2320 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964786AbWCTNhc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:37:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hLaMxmM5VeYYUW0UYE2+MwUTPE3jBLZt0T0Y20ht7tWlNPbKqnd/0lLlEwAux3Rz1GuxqDS+Ilih/iA4ycq3QPP5jcBuMVzmuWtS7UjI8xYsyLTR6cEcXh9B4vz+z6rkJqzfQoI1iwGoWyFs/TJfbNKzNHxKN+z3Z0Nxf9iAz+c=
Message-ID: <bc56f2f0603200537t234d75aau@mail.gmail.com>
Date: Mon, 20 Mar 2006 08:37:30 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: akpm@osdl.org
Subject: [PATCH][4/8] Documentation/vm: minor corrections
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor corrections of vm documentation.

Signed-off-by: Shaoping Wang <pwstone@gmail.com>

--
 hugetlbpage.txt |    2 +-
 locking         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -urN  linux-2.6.15.orig/Documentation/vm/hugetlbpage.txt
linux-2.6.15/Documentation/vm/hugetlbpage.txt
--- linux-2.6.15.orig/Documentation/vm/hugetlbpage.txt	2006-01-02
22:21:10.000000000 -0500
+++ linux-2.6.15/Documentation/vm/hugetlbpage.txt	2006-03-06
06:30:06.000000000 -0500
@@ -59,7 +59,7 @@

 This command will try to configure 20 hugepages in the system.  The success
 or failure of allocation depends on the amount of physically contiguous
-memory that is preset in system at this time.  System administrators may want
+memory that is present in system at this time.  System administrators may want
 to put this command in one of the local rc init file.  This will enable the
 kernel to request huge pages early in the boot process (when the possibility
 of getting physical contiguous pages is still very high).
diff -urN  linux-2.6.15.orig/Documentation/vm/locking
linux-2.6.15/Documentation/vm/locking
--- linux-2.6.15.orig/Documentation/vm/locking	2006-01-02
22:21:10.000000000 -0500
+++ linux-2.6.15/Documentation/vm/locking	2006-03-07 03:43:44.000000000 -0500
@@ -37,7 +37,7 @@
 4. The exception to this rule is expand_stack, which just
    takes the read lock and the page_table_lock, this is ok
    because it doesn't really modify fields anybody relies on.
-5. You must be able to guarantee that while holding page_table_lock
+5. You must be able to guarantee that while holding mmap_sem
    or page_table_lock of mm A, you will not try to get either lock
    for mm B.
