Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbTJPK1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbTJPK1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:27:10 -0400
Received: from genesis.westend.com ([212.117.67.2]:4504 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP id S262799AbTJPK1I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:27:08 -0400
Subject: Getting Fasttrak TX2 Raid Controler to work.
From: Kai Militzer <km@westend.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 16 Oct 2003 12:31:08 +0200
Message-Id: <1066300268.1252.21.camel@bart>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone!

I tried to get a 2.4.22 kernel to work with support for the Promise
Fasttrak TX2 controller.

lspci says the following about the controller:
00:0a.0 RAID bus controller: Promise Technology, Inc.:Unknown device
6268 (rev 02)

I included
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_PDC202XX_FORCE=y
CONFIG_BLK_DEV_ATARAID=y
CONFIG_BLK_DEV_ATARAID_PDC=y

in the .config-file

When booting the kernel I compiled this way, it detects the Fasttrak,
but won't load the RAID, also it is directly compiled into the kernel
and not as a module, and can't mount the VFS on /dev/ataraid/d0p*

This is no hardware problem or else, because with a debian 2.4.18-bf24
kernel the systems boots without a problem and I can use all devices
under /dev/ataraid/d0p*

Does anyone have an idea how I can get this to work? Thank you in
advance.

Best Regards,

Kai

-- 
Kai Militzer                 WESTEND GmbH  |  Internet-Business-Provider
Technik                      CISCO Systems Partner - Authorized Reseller
                             Lütticher Straße 10      Tel 0241/701333-11
km@westend.com               D-52064 Aachen              Fax 0241/911879


