Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbVFVFhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbVFVFhl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVFVFeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:34:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:40599 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262755AbVFVFMS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:18 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: fix compiler warnings
In-Reply-To: <11194171282338@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:08 -0700
Message-Id: <11194171283762@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: fix compiler warnings

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

---
commit e5c515b4532f4aac2b1136612d8c3ecd1891f431
tree c0a20bf5fd930bdfaf3b40748c266a935e725c6b
parent 6adf87bd7b7832105b9c6bc08adf6a4d229f1e79
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Fri, 10 Jun 2005 14:53:22 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:12 -0700

 drivers/w1/w1_family.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c
+++ b/drivers/w1/w1_family.c
@@ -27,6 +27,7 @@
 
 DEFINE_SPINLOCK(w1_flock);
 static LIST_HEAD(w1_families);
+extern void w1_reconnect_slaves(struct w1_family *f);
 
 static int w1_check_family(struct w1_family *f)
 {

