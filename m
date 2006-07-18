Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWGRSdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWGRSdu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 14:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWGRSdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 14:33:50 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:44266 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932344AbWGRSdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 14:33:49 -0400
Message-ID: <44BD2A07.7080200@oracle.com>
Date: Tue, 18 Jul 2006 11:35:51 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>
Subject: [PATCH] fix kernel-api doc for kernel/resource.c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

insert_resource() was unexported, so kernel-doc needs to be told
to search kernel/resource.c for internal functions instead of
exported functions so that it won't report an error.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2618-rc2.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2618-rc2/Documentation/DocBook/kernel-api.tmpl
@@ -300,7 +300,7 @@ X!Ekernel/module.c
      </sect1>
 
      <sect1><title>Resources Management</title>
-!Ekernel/resource.c
+!Ikernel/resource.c
      </sect1>
 
      <sect1><title>MTRR Handling</title>

