Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbUC3RpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbUC3RpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:45:23 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:45752 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263789AbUC3Rov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:44:51 -0500
Message-Id: <200403301744.i2UHiT9b001846@ginger.cmf.nrl.navy.mil>
To: davem@redhat.com
cc: Willy TARREAU <willy@w.ods.org>, Chris Wedgwood <cw@f00f.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.4.26] ATM cleanup 
In-Reply-To: Message from Willy TARREAU <willy@w.ods.org> 
   of "Sun, 28 Mar 2004 15:08:11 +0200." <20040328130811.GA7345@pcw.home.local> 
Date: Tue, 30 Mar 2004 12:44:30 -0500
From: "chas williams (contractor)" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please apply to the 2.4 and 2.6 kernels.

thanks!


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1717  -> 1.1718 
#	 net/atm/mpoa_proc.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/30	chas@relax.cmf.nrl.navy.mil	1.1718
# [ATM]: mpoa_proc warning cleanup (from Willy TARREAU <willy@w.ods.org>)
# --------------------------------------------
#
diff -Nru a/net/atm/mpoa_proc.c b/net/atm/mpoa_proc.c
--- a/net/atm/mpoa_proc.c	Tue Mar 30 12:41:47 2004
+++ b/net/atm/mpoa_proc.c	Tue Mar 30 12:41:47 2004
@@ -103,7 +103,7 @@
 			     size_t count, loff_t *pos){
         unsigned long page = 0;
 	unsigned char *temp;
-        ssize_t length  = 0;
+        int length = 0;
 	int i = 0;
 	struct mpoa_client *mpc = mpcs;
 	in_cache_entry *in_entry;
