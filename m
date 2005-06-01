Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVFASFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVFASFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVFASFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:05:14 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:13444 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261518AbVFASDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:03:12 -0400
Date: Wed, 1 Jun 2005 20:03:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 5/11] s390: #ifdefs in compat_ioctls.
Message-ID: <20050601180312.GE6418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/11] s390: #ifdefs in compat_ioctls.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Remove superflous #if .. #endif pairs from compat_ioctl.c.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/compat_ioctl.c |    6 ------
 1 files changed, 6 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_ioctl.c linux-2.6-patched/arch/s390/kernel/compat_ioctl.c
--- linux-2.6/arch/s390/kernel/compat_ioctl.c	2005-06-01 19:42:54.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_ioctl.c	2005-06-01 19:43:17.000000000 +0200
@@ -42,7 +42,6 @@ struct ioctl_trans ioctl_start[] = {
 #include "../../../fs/compat_ioctl.c"
 
 /* s390 only ioctls */
-#if defined(CONFIG_DASD) || defined(CONFIG_DASD_MODULE)
 COMPATIBLE_IOCTL(DASDAPIVER)
 COMPATIBLE_IOCTL(BIODASDDISABLE)
 COMPATIBLE_IOCTL(BIODASDENABLE)
@@ -59,16 +58,11 @@ COMPATIBLE_IOCTL(BIODASDPRRD)
 COMPATIBLE_IOCTL(BIODASDPSRD)
 COMPATIBLE_IOCTL(BIODASDGATTR)
 COMPATIBLE_IOCTL(BIODASDSATTR)
-#if defined(CONFIG_DASD_CMB) || defined(CONFIG_DASD_CMB_MODULE)
 COMPATIBLE_IOCTL(BIODASDCMFENABLE)
 COMPATIBLE_IOCTL(BIODASDCMFDISABLE)
 COMPATIBLE_IOCTL(BIODASDREADALLCMB)
-#endif
-#endif
 
-#if defined(CONFIG_S390_TAPE) || defined(CONFIG_S390_TAPE_MODULE)
 COMPATIBLE_IOCTL(TAPE390_DISPLAY)
-#endif
 
 /* s390 doesn't need handlers here */
 COMPATIBLE_IOCTL(TIOCGSERIAL)
