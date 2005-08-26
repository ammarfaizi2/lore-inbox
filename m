Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVHZHzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVHZHzO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 03:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbVHZHzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 03:55:14 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15503 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750777AbVHZHzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 03:55:13 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] %n.n -> %0n printf format specifiers
Date: Fri, 26 Aug 2005 10:54:59 +0300
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508261055.00190.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

We have ~2k of printf format specs like this:

"%s: Transmit timed out, status %4.4x, PHY status %4.4x, resetting...\n"

IIRC %04x and %4.4x are totally equivalent. %04 is shorter.

Patches are at http://195.66.192.167/linux/printf_patch/

Largest ones are:

# ls -l | sort -r
total 1012
-rw-r--r--   1 root     root        11424 Aug 26 10:49 3c59x.c.patch
-rw-r--r--   1 root     root         8985 Aug 26 10:50 yellowfin.c.patch
-rw-r--r--   1 root     root         8692 Aug 26 10:50 lec.c.patch
-rw-r--r--   1 root     root         8619 Aug 26 10:50 hamachi.c.patch
-rw-r--r--   1 root     root         8571 Aug 26 10:49 3c515.c.patch
-rw-r--r--   1 root     root         7829 Aug 26 10:50 winbond-840.c.patch
-rw-r--r--   1 root     root         7526 Aug 26 10:50 eepro100.c.patch
-rw-r--r--   1 root     root         7456 Aug 26 10:50 virgefb.c.patch
-rw-r--r--   1 root     root         7255 Aug 26 10:50 epic100.c.patch
-rw-r--r--   1 root     root         6725 Aug 26 10:49 8139too.c.patch
-rw-r--r--   1 root     root         6448 Aug 26 10:50 pci-skeleton.c.patch
-rw-r--r--   1 root     root         6403 Aug 26 10:50 via-rhine.c.patch
-rw-r--r--   1 root     root         5944 Aug 26 10:50 sundance.c.patch
-rw-r--r--   1 root     root         5944 Aug 26 10:50 l2cap.c.patch
-rw-r--r--   1 root     root         5811 Aug 26 10:50 ixj.c.patch
-rw-r--r--   1 root     root         5052 Aug 26 10:50 xircom_tulip_cb.c.patch
-rw-r--r--   1 root     root         4991 Aug 26 10:50 tulip_core.c.patch
-rw-r--r--   1 root     root         4958 Aug 26 10:50 interrupt.c.patch
-rw-r--r--   1 root     root         4610 Aug 26 10:50 media.c.patch
-rw-r--r--   1 root     root         4449 Aug 26 10:50 depca.c.patch
-rw-r--r--   1 root     root         4281 Aug 26 10:49 3c509.c.patch
-rw-r--r--   1 root     root         4236 Aug 26 10:50 21142.c.patch
-rw-r--r--   1 root     root         3780 Aug 26 10:49 raw1394.c.patch
-rw-r--r--   1 root     root         3733 Aug 26 10:49 residual.c.patch
-rw-r--r--   1 root     root         3561 Aug 26 10:50 pnic2.c.patch
-rw-r--r--   1 root     root         3353 Aug 26 10:50 fealnx.c.patch
-rw-r--r--   1 root     root         3246 Aug 26 10:50 sis900.c.patch
-rw-r--r--   1 root     root         3193 Aug 26 10:50 pcnet32.c.patch
-rw-r--r--   1 root     root         3184 Aug 26 10:49 cdu31a.c.patch
-rw-r--r--   1 root     root         3122 Aug 26 10:50 smc91c92_cs.c.patch
...

Feel free to grab & apply to your driver(s).
--
vda
