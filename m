Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264100AbUDBQjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 11:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbUDBQjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 11:39:15 -0500
Received: from bay2-f51.bay2.hotmail.com ([65.54.247.51]:6661 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264100AbUDBQjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 11:39:14 -0500
X-Originating-IP: [209.172.74.2]
X-Originating-Email: [idht4n@hotmail.com]
From: "David L" <idht4n@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: mtd - No flash chips recognised.
Date: Fri, 02 Apr 2004 08:39:10 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F51ktUhFFWfBnj0002977e@hotmail.com>
X-OriginalArrivalTime: 02 Apr 2004 16:39:11.0417 (UTC) FILETIME=[06C74290:01C418D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to use 2.6.4 with a Mobile DiskOnChip.  I get the message
"No flash chips recognised".  It looks like the DoC_IdentChip function
in doc2001.c is finding a nand_flash_id of 0xa5, which isn't one of the
ids listed in nand_ids.c.  Am I using the wrong driver or is this chip not
yet supported?  If it's not supported, would it make sense to add a
placeholder to drivers/mtd/devices/Kconfig like:

config MTD_DOCMOBILE
	tristate "M-Systems Mobile Disk-On-Chip (not yet supported!)"
	depends on MTD
	---help---
	  This chip is not yet supported... this is just a placeholder.

Thanks:

                         David

_________________________________________________________________
Is your PC infected? Get a FREE online computer virus scan from McAfee® 
Security. http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

