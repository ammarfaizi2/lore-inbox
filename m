Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932926AbWJIPOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926AbWJIPOB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbWJIPOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:14:01 -0400
Received: from xenotime.net ([66.160.160.81]:62680 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932926AbWJIPOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:14:00 -0400
Date: Mon, 9 Oct 2006 08:15:27 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH v2] kernel-doc: drop various "inline"  qualifiers
Message-Id: <20061009081527.d37a1c22.rdunlap@xenotime.net>
In-Reply-To: <200610091500.24131.eike-kernel@sf-tec.de>
References: <20061008200851.47eb99da.rdunlap@xenotime.net>
	<200610091500.24131.eike-kernel@sf-tec.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 15:00:18 +0200 Rolf Eike Beer wrote:

> The inline status of a function is not of much help for a developer, that's 
> right. But I would like to see the the __must_check in the documentation. 
> This it what makes a difference, the inline stuff is extraneous.

---
From: Randy Dunlap <rdunlap@xenotime.net>

Drop __inline, __always_inline, and noinline in the
produced kernel-doc output, similar to other pseudo directives.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/kernel-doc |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2619-rc1g3.orig/scripts/kernel-doc
+++ linux-2619-rc1g3/scripts/kernel-doc
@@ -1518,6 +1518,9 @@ sub dump_function($$) {
     $prototype =~ s/^asmlinkage +//;
     $prototype =~ s/^inline +//;
     $prototype =~ s/^__inline__ +//;
+    $prototype =~ s/^__inline +//;
+    $prototype =~ s/^__always_inline +//;
+    $prototype =~ s/^noinline +//;
     $prototype =~ s/__devinit +//;
     $prototype =~ s/^#define +//; #ak added
     $prototype =~ s/__attribute__ \(\([a-z,]*\)\)//;
