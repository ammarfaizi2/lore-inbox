Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUJIJrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUJIJrt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 05:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUJIJrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 05:47:49 -0400
Received: from fmr12.intel.com ([134.134.136.15]:39859 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S266646AbUJIJrr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 05:47:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH x86_64]: Add TCSBRKP ioctl translation for arch/x86_64/ia32
Date: Sat, 9 Oct 2004 17:47:42 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E848AF8D0@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH x86_64]: Add TCSBRKP ioctl translation for arch/x86_64/ia32
Thread-Index: AcSt5QWpVL6ooJXiR0KPkdX8I02GAA==
From: "Jin, Gordon" <gordon.jin@intel.com>
To: <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Oct 2004 09:47:43.0827 (UTC) FILETIME=[06507A30:01C4ADE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch adds TCSBRKP ioctl translation for arch/x86_64/ia32.
TCSBRKP is needed for POSIX tcsendbreak().
Some archs (such as sparc64) have added TCSBRKP in their compat codes,
Here is for x86_64.

Signed-off-by: Gordon Jin <gordon.jin@intel.com>

--- linux-2.6.8/arch/x86_64/ia32/ia32_ioctl.c.orig	2004-09-23 09:21:20.000000000 -0700
+++ linux-2.6.8/arch/x86_64/ia32/ia32_ioctl.c	2004-09-23 09:22:31.000000000 -0700
@@ -189,6 +189,7 @@ COMPATIBLE_IOCTL(RTC_SET_TIME)
 COMPATIBLE_IOCTL(RTC_WKALM_SET)
 COMPATIBLE_IOCTL(RTC_WKALM_RD)
 COMPATIBLE_IOCTL(FIOQSIZE)
+COMPATIBLE_IOCTL(TCSBRKP)
 
 /* And these ioctls need translation */
 HANDLE_IOCTL(TIOCGDEV, tiocgdev)

Thanks,
Gordon 
