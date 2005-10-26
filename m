Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbVJZAX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVJZAX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 20:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVJZAXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 20:23:55 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:48545 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932504AbVJZAXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 20:23:55 -0400
Subject: [PATCH 01/02] Export Connector Symbol
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>
In-Reply-To: <1130285260.10680.194.camel@stark>
References: <1130285260.10680.194.camel@stark>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 17:16:25 -0700
Message-Id: <1130285785.10680.205.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        The Process Events Connector uses this symbol to determine if it
should respond to commands from userspace. However the it fails to link
without the EXPORT_SYMBOL_GPL() macro.

Signed-Off-By: Matt Helsley <matthltc @ us.ibm.com> 

--

Resent with the subject line fixed.

---

Index: linux-2.6.14-rc4/drivers/connector/connector.c
===================================================================
--- linux-2.6.14-rc4.orig/drivers/connector/connector.c
+++ linux-2.6.14-rc4/drivers/connector/connector.c
@@ -45,10 +45,11 @@ static DECLARE_MUTEX(notify_lock);
 static LIST_HEAD(notify_list);
 
 static struct cn_dev cdev;
 
 int cn_already_initialized = 0;
+EXPORT_SYMBOL_GPL(cn_already_initialized);
 
 /*
  * msg->seq and msg->ack are used to determine message genealogy.
  * When someone sends message it puts there locally unique sequence
  * and random acknowledge numbers.  Sequence number may be copied into


