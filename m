Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161167AbWAUEHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbWAUEHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 23:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161229AbWAUEHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 23:07:05 -0500
Received: from xenotime.net ([66.160.160.81]:9929 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161167AbWAUEHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 23:07:03 -0500
Date: Fri, 20 Jan 2006 20:07:05 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] doc: make doc. for maxcpus= more visible
Message-Id: <20060120200705.798e4712.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Some people are confused about maxcpus=1 and maxcpus=0,
so put the documentation text from init/main.c into
Documentation/kernel-parameters.txt also.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/kernel-parameters.txt |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

--- linux-2616-rc1-secur.orig/Documentation/kernel-parameters.txt
+++ linux-2616-rc1-secur/Documentation/kernel-parameters.txt
@@ -801,7 +801,14 @@ running once the system is up.
 			Format: <1-256>
 
 	maxcpus=	[SMP] Maximum number of processors that	an SMP kernel
-			should make use of
+			should make use of.
+			Using "nosmp" or "maxcpus=0" will disable SMP
+			entirely (the MPS table probe still happens, though).
+			A command-line option of "maxcpus=<NUM>", where <NUM>
+			is an integer greater than 0, limits the maximum number
+			of CPUs activated in SMP mode to <NUM>.
+			Using "maxcpus=1" on an SMP kernel is the trivial
+			case of an SMP kernel with only one CPU.
 
 	max_addr=[KMG]	[KNL,BOOT,ia64] All physical memory greater than or
 			equal to this physical address is ignored.


---
