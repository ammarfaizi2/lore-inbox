Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVCFBxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVCFBxA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 20:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVCFBw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 20:52:59 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:49316 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261294AbVCFBwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 20:52:35 -0500
Message-ID: <422A625E.3060009@drzeus.cx>
Date: Sun, 06 Mar 2005 02:52:30 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-27822-1110074037-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC][5/6] Secure Digital (SD) support : sysfs
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx> <20050305124420.A342@flint.arm.linux.org.uk> <422A5E1C.2050107@drzeus.cx>
In-Reply-To: <422A5E1C.2050107@drzeus.cx>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-27822-1110074037-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

SCR sysfs access.

This provides access to the SCR register via sysfs. Since the latest bk 
contains some changes to the sysfs part this probably needs updating. 
The patch is trivial though so it should be easy.


--=_hades.drzeus.cx-27822-1110074037-0001-2
Content-Type: text/x-patch; name="mmc-sd-sysfs.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-sd-sysfs.patch"

Index: linux-sd/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-sd/drivers/mmc/mmc_sysfs.c	(revision 135)
+++ linux-sd/drivers/mmc/mmc_sysfs.c	(working copy)
@@ -163,6 +163,7 @@
 	card->raw_cid[2], card->raw_cid[3]);
 MMC_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1],
 	card->raw_csd[2], card->raw_csd[3]);
+MMC_ATTR(scr, "%08x%08x\n", card->raw_scr[0], card->raw_scr[1]);
 MMC_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
 MMC_ATTR(fwrev, "0x%x\n", card->cid.fwrev);
 MMC_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
@@ -174,6 +175,7 @@
 static struct device_attribute *mmc_dev_attributes[] = {
 	&dev_attr_cid,
 	&dev_attr_csd,
+	&dev_attr_scr,
 	&dev_attr_date,
 	&dev_attr_fwrev,
 	&dev_attr_hwrev,

--=_hades.drzeus.cx-27822-1110074037-0001-2--
