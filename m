Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268159AbVBFAqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268159AbVBFAqU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267766AbVBFAmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:42:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36369 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S272767AbVBFAiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:38:22 -0500
Date: Sun, 6 Feb 2005 01:38:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: werner@isdn4linux.de
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/divert/isdn_divert.c: make 5 functions static
Message-ID: <20050206003819.GL3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes five needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/divert/isdn_divert.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.11-rc3-mm1-full/drivers/isdn/divert/isdn_divert.c.old	2005-02-05 15:39:15.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/divert/isdn_divert.c	2005-02-05 15:39:52.000000000 +0100
@@ -383,7 +383,7 @@
 /*************************************************/
 /* called from common module on an incoming call */
 /*************************************************/
-int isdn_divert_icall(isdn_ctrl *ic)
+static int isdn_divert_icall(isdn_ctrl *ic)
 { int retval = 0;
   unsigned long flags;
   struct call_struc *cs = NULL; 
@@ -552,7 +552,7 @@
 /****************************************************/
 /* put a address including address type into buffer */
 /****************************************************/
-int put_address(char *st, u_char *p, int len)
+static int put_address(char *st, u_char *p, int len)
 { u_char retval = 0;
   u_char adr_typ = 0; /* network standard */
 
@@ -595,7 +595,7 @@
 /*************************************/
 /* report a succesfull interrogation */
 /*************************************/
-int interrogate_success(isdn_ctrl *ic, struct call_struc *cs)
+static int interrogate_success(isdn_ctrl *ic, struct call_struc *cs)
 { char *src = ic->parm.dss1_io.data;
   int restlen = ic->parm.dss1_io.datalen;
   int cnt = 1;
@@ -689,7 +689,7 @@
 /*********************************************/
 /* callback for protocol specific extensions */
 /*********************************************/
-int prot_stat_callback(isdn_ctrl *ic)
+static int prot_stat_callback(isdn_ctrl *ic)
 { struct call_struc *cs, *cs1;
   int i;
   unsigned long flags;
@@ -781,7 +781,7 @@
 /***************************/
 /* status callback from HL */
 /***************************/
-int isdn_divert_stat_callback(isdn_ctrl *ic)
+static int isdn_divert_stat_callback(isdn_ctrl *ic)
 { struct call_struc *cs, *cs1;
   unsigned long flags;
   int retval;

