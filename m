Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbTLRPfF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 10:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTLRPfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 10:35:05 -0500
Received: from mailwasher.lanl.gov ([192.16.0.25]:12484 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S265215AbTLRPe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 10:34:59 -0500
Subject: [PATCH] 2.4.24-pre1 update scripts/ver_linux  for xfsprogs.
From: Steven Cole <elenstev@mesatop.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1071761579.1625.20.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 18 Dec 2003 08:32:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

Here is a patch to update the ver_linux script for xfsprogs.

This was copied from 2.6 and the patch was made against the current 2.4
tree.

Steven

--- 2.4-12_18/scripts/ver_linux.orig	Thu Dec 18 07:30:31 2003
+++ 2.4-12_18/scripts/ver_linux	Thu Dec 18 07:34:53 2003
@@ -39,6 +39,9 @@
 reiserfsck -V 2>&1 | grep reiserfsprogs | awk \
 'NR==1{print "reiserfsprogs         ", $NF}'
 
+xfs_db -V 2>&1 | grep version | awk \
+'NR==1{print "xfsprogs              ", $3}'
+
 cardmgr -V 2>&1| grep version | awk \
 'NR==1{print "pcmcia-cs             ", $3}'
 



