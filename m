Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423877AbWKIPCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423877AbWKIPCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423881AbWKIPCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:02:42 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:37051 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423877AbWKIPCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:02:41 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
Organization: IBM
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC,PATCH 2/2] Oprofile-on-Cell prereqs: Export hrtimer_forward
Date: Thu, 9 Nov 2006 09:02:39 -0600
User-Agent: KMail/1.8.3
References: <200611090858.11590.kevcorry@us.ibm.com>
In-Reply-To: <200611090858.11590.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611090902.39714.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a symbol-export for kernel/hrtimer.c::hrtimer_forward(). This routine
is needed by the upcoming Oprofile-for-Cell patches, since Oprofile can
be built as a module.

Signed-Off-By: Kevin Corry <kevcorry@us.ibm.com>

Index: linux-2.6.18-arnd5/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-arnd5.orig/kernel/hrtimer.c
+++ linux-2.6.18-arnd5/kernel/hrtimer.c
@@ -335,6 +335,7 @@ hrtimer_forward(struct hrtimer *timer, k
 
 	return orun;
 }
+EXPORT_SYMBOL_GPL(hrtimer_forward);
 
 /*
  * enqueue_hrtimer - internal function to (re)start a timer
