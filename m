Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVBRL2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVBRL2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 06:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVBRL2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 06:28:22 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:39670 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261336AbVBRL2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 06:28:11 -0500
From: "Sven Dietrich" <sdietrich@mvista.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "Rt-Dev@Mvista. Com" <rt-dev@mvista.com>
Subject: Realtime preempt 
Date: Fri, 18 Feb 2005 03:28:08 -0800
Message-ID: <001901c515ac$ec8032f0$6d00a8c0@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20050217080304.GA21887@elte.hu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,

this patch turns off the preemptable BKL when 
either PREEMPT_VOLUNTARY or PREEMPT_NONE is selected.

Signed-off-by: Sven-Thorsten Dietrich <sdietrich@mvista.com>

Index: linux-2.6.10-vaio/lib/Kconfig.RT
===================================================================
--- linux-2.6.10-vaio.orig/lib/Kconfig.RT       2005-02-18 11:13:42.050554215 +0000
+++ linux-2.6.10-vaio/lib/Kconfig.RT    2005-02-18 11:20:16.021273614 +0000
@@ -144,5 +144,6 @@
 config PREEMPT_BKL
        bool
        depends on PREEMPT_RT || !SPINLOCK_BKL
+       default n if !PREEMPT
        default y


