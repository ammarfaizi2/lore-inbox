Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751946AbWITQtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbWITQtc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbWITQtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:49:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:4797 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751946AbWITQtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:49:19 -0400
Subject: [PATCH] integrity: cleanup use of config.h
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>, akpm@osdl.org
In-Reply-To: <20060918205412.GA2640@redhat.com>
References: <1158083873.18137.14.camel@localhost.localdomain>
	 <1158611418.14194.70.camel@moss-spartans.epoch.ncsc.mil>
	 <1158612642.16727.53.camel@localhost.localdomain>
	 <20060918205412.GA2640@redhat.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:49:08 -0700
Message-Id: <1158770948.16727.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses this comment about the use of config.h in the
integrity .c files. 

On Mon, 2006-09-18 at 16:54 -0400, Dave Jones wrote: 
> You don't need to include config.h any more, kbuild does it for you.
> (Might want to check the other files for the same thing).
> 
> 	Dave

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
---
security/integrity.c       |    1 -
security/integrity_dummy.c |    1 -
2 files changed, 2 deletions(-)

--- linux-2.6.18-rc6-orig/security/integrity_dummy.c	2006-09-18 16:41:48.000000000 -0500
+++ linux-2.6.18-rc6/security/integrity_dummy.c	2006-09-19 14:33:36.000000000 -0500
@@ -11,7 +11,6 @@
  *      the Free Software Foundation, version 2 of the License.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
--- linux-2.6.18-rc6-orig/security/integrity.c	2006-09-18 16:41:28.000000000 -0500
+++ linux-2.6.18-rc6/security/integrity.c	2006-09-19 14:33:43.000000000 -0500
@@ -11,7 +11,6 @@
  *      the Free Software Foundation, version 2 of the License.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>


