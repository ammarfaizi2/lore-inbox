Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVAMSxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVAMSxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVAMSvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:51:40 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:21928 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261437AbVAMSq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:46:27 -0500
Message-ID: <41E6C1FF.4000203@us.ltcfwd.linux.ibm.com>
Date: Thu, 13 Jan 2005 12:46:23 -0600
From: Mike Wolf <mjw@us.ibm.com>
Reply-To: mjw@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
CC: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: 32bit wrapper for ioctls.
Content-Type: multipart/mixed;
 boundary="------------040508090506070106010308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040508090506070106010308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paul,
  The patch adds some 32bit wrappers for 2 ioctls that Java needs.
Assuming this doesn't generate a round of discussion, please
forward upstream to akpm/torvalds.

Signed-off-by: Mike Wolf  mjw@us.ibm.com

--------------040508090506070106010308
Content-Type: text/x-patch;
 name="ioctl32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioctl32.patch"

--- linus-0112.orig/arch/ppc64/kernel/ioctl32.c	2005-01-13 10:35:10.165539000 -0600
+++ linus-0112/arch/ppc64/kernel/ioctl32.c	2005-01-13 10:51:43.450433277 -0600
@@ -43,6 +43,8 @@
 COMPATIBLE_IOCTL(TIOCSTART)
 COMPATIBLE_IOCTL(TIOCSTOP)
 COMPATIBLE_IOCTL(TIOCSLTC)
+COMPATIBLE_IOCTL(TIOCMIWAIT)
+COMPATIBLE_IOCTL(TIOCGICOUNT)
 /* Little p (/dev/rtc, /dev/envctrl, etc.) */
 COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) /* RTCGET */
 COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */

--------------040508090506070106010308--
