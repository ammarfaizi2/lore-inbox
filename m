Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUFNBeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUFNBeh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 21:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUFNBeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 21:34:37 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:31022 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261474AbUFNBeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 21:34:36 -0400
Message-ID: <40CCBBA7.4030203@myrealbox.com>
Date: Sun, 13 Jun 2004 13:40:07 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Ben Collins <bcollins@debian.org>
Subject: [PATCH 2.6.7-bk]  Typo in ohci1994.c ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This corrected a missing symbol error in the latest bk changesets:

--- drivers/ieee1394/ohci1394.c 2004-06-13 13:31:49.918402152 -0700
+++ /tmp/ohci1394.c     2004-06-13 13:31:26.896901952 -0700
@@ -517,7 +517,7 @@
                 1<<(((reg_read(ohci, OHCI1394_BusOptions)>>12)&0xf)+1);

         if (ohci->max_packet_size < 512) {
-               HPSB_WARNING("warning: Invalid max packet size of %d, setting to 512",
+               HPSB_WARN("warning: Invalid max packet size of %d, setting to 512",
                              ohci->max_packet_size);
                 ohci->max_packet_size = 512;
         }
