Return-Path: <linux-kernel-owner+w=401wt.eu-S932082AbXAPJxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbXAPJxo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 04:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbXAPJxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 04:53:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:14365 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbXAPJxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 04:53:43 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=So4GU7gW96Fkcf+j+/sfSjKJ+hHUT5eamh8uEi8kIVo42cfuoJD3hVQ4nrVW4EAx8iH8vZXpTonB4lawBgNR/EpKaktzIYAcNp60eP0WgwzFde5EvDYyZoFk8lu08tOZmNSRrMIoakINMiRXAuoyEDc1wmIwahEdKJIqZKPg7Fw=
Date: Tue, 16 Jan 2007 11:53:19 +0200
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH 2.6.20-rc5] isdn/capi: use ARRAY_SIZE when appropriate
Message-ID: <20070116095319.GB718@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

A trivial patch to use ARRAY_SIZE macro defined in kernel.h instead
of reimplementing it.

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---

capi.c    |    4 ++--
capidrv.c |    4 ++--
2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index d22c022..3804591 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1456,7 +1456,7 @@ static struct procfsentries {
 
 static void __init proc_init(void)
 {
-    int nelem = sizeof(procfsentries)/sizeof(procfsentries[0]);
+    int nelem = ARRAY_SIZE(procfsentries);
     int i;
 
     for (i=0; i < nelem; i++) {
@@ -1468,7 +1468,7 @@ static void __init proc_init(void)
 
 static void __exit proc_exit(void)
 {
-    int nelem = sizeof(procfsentries)/sizeof(procfsentries[0]);
+    int nelem = ARRAY_SIZE(procfsentries);
     int i;
 
     for (i=nelem-1; i >= 0; i--) {
diff --git a/drivers/isdn/capi/capidrv.c b/drivers/isdn/capi/capidrv.c
index c4d438c..8cec9c3 100644
--- a/drivers/isdn/capi/capidrv.c
+++ b/drivers/isdn/capi/capidrv.c
@@ -2218,7 +2218,7 @@ static struct procfsentries {
 
 static void __init proc_init(void)
 {
-    int nelem = sizeof(procfsentries)/sizeof(procfsentries[0]);
+    int nelem = ARRAY_SIZE(procfsentries);
     int i;
 
     for (i=0; i < nelem; i++) {
@@ -2230,7 +2230,7 @@ static void __init proc_init(void)
 
 static void __exit proc_exit(void)
 {
-    int nelem = sizeof(procfsentries)/sizeof(procfsentries[0]);
+    int nelem = ARRAY_SIZE(procfsentries);
     int i;
 
     for (i=nelem-1; i >= 0; i--) {

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
