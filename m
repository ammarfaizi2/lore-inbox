Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVFBIB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVFBIB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVFBIA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:00:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14023 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261190AbVFBH6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:58:47 -0400
Date: Thu, 2 Jun 2005 16:03:12 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 7/9] dlm: don't repeat include
Message-ID: <20050602080312.GG21570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="repeated-module-include.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

module.h is included by dlm_internal.h so it doesn't need to be included
explicitly.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/lock.c
===================================================================
--- linux.orig/drivers/dlm/lock.c	2005-06-02 12:28:30.000000000 +0800
+++ linux/drivers/dlm/lock.c	2005-06-02 13:08:59.183450328 +0800
@@ -56,8 +56,6 @@
    L: receive_xxxx_reply()     <-  R: send_xxxx_reply()
 */
 
-#include <linux/module.h>
-
 #include "dlm_internal.h"
 #include "memory.h"
 #include "lowcomms.h"

--

