Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWBGDny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWBGDny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWBGDny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:43:54 -0500
Received: from adsl-67-65-14-121.dsl.austtx.swbell.net ([67.65.14.121]:37545
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S964961AbWBGDnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:43:53 -0500
Subject: RE: [PATCH] [RESEND] Add Dell laptop backlight brightness display
From: Michael E Brown <michael_e_brown@Dell.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@osdl.org>, matt_domsch@Dell.com,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 06 Feb 2006 21:43:16 -0600
Message-Id: <1139283796.28567.179.camel@soltek.michaels-house.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew, Andrew,
	(sorry, I'm not subscribed to l-k, so I'm just starting a new thread.)

	I would _strongly_ suggest that this patch _not_ go in. This driver
uses hardcoded values that are subject to change without notice. It is
perfectly legitimate for future versions of Dell BIOS to interpret pokes
to cmos location 0x99 as the command to format your hard drive.

	The proper way to do this is using libsmbios. The project page is at
http://linux.dell.com/libsmbios/main.  Using libsmbios, plus the
already-included dcdbas kernel driver, you can correctly do brightness
control. If you would like to write a proper brightness control, it can
be done entirely in user space, and I could help you.

	There are specific smbios structures, proprietary to Dell, that are
documented in libsmbios. These structures, properly decoded, tell the
proper port to use to control this. This is guaranteed to work across
BIOS versions and not to format your hard drive. :-)

	Libsmbios is 100% open source (dual GPL/OSL license).

--
Michael Brown
Libsmbios maintainer

