Return-Path: <linux-kernel-owner+w=401wt.eu-S1755103AbWL3AFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103AbWL3AFK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 19:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755105AbWL3AFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 19:05:09 -0500
Received: from main.gmane.org ([80.91.229.2]:37411 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103AbWL3AFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 19:05:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Megacz <megacz@cs.berkeley.edu>
Subject: OpenAFS gatekeepers request addition of AFS_SUPER_MAGIC to magic.h
Date: Fri, 29 Dec 2006 15:56:12 -0800
Organization: Myself
Message-ID: <x3fyay2r4z.fsf@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 216.237.119.187
X-Home-Page: http://www.megacz.com/
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:9b1tDaxaEcFegbN0rMjsgHeXzBs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Jeffrey Altman, one of the gatekeepers of OpenAFS (the open source
project which inherited the Transarc/IBM AFS codebase) has requested
that the magic number 0x5346414F (little endian 'OAFS') be allocated
for the f_type field of the fsinfo structure on Linux:

  https://lists.openafs.org/pipermail/openafs-info/2006-December/024829.html

I would like to offer the patch below for inclusion in the source
tree, if possible.  The patch adds it to include/linux/magic.h, mostly
as a way of publishing this number and ensuring that no other
filesystem accidentally uses it.

  - a


--- include/linux/magic.h       2006-12-29 15:48:50.000000000 -0800
+++ include/linux/magic.h       2006-11-29 13:57:37.000000000 -0800
@@ -3,7 +3,6 @@
 
 #define ADFS_SUPER_MAGIC       0xadf5
 #define AFFS_SUPER_MAGIC       0xadff
-#define AFS_SUPER_MAGIC                0x5346414F
 #define AUTOFS_SUPER_MAGIC     0x0187
 #define CODA_SUPER_MAGIC       0x73757245
 #define EFS_SUPER_MAGIC                0x414A53

