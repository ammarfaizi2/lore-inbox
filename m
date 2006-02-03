Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWBCQYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWBCQYP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWBCQYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:24:14 -0500
Received: from mail.avm.de ([194.175.125.228]:25230 "EHLO mail.avm.de")
	by vger.kernel.org with ESMTP id S1751168AbWBCQYO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:24:14 -0500
In-Reply-To: <200601200904.00389.dazzle.digital@gmail.com>
Subject: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of major
 vendor excluded
To: linux-kernel@vger.kernel.org, opensuse-factory@opensuse.org
Cc: kkeil@suse.de
X-Mailer: Lotus Notes Release 6.5.2 June 01, 2004
Message-ID: <OF7A130C3D.76EBAB24-ONC125710A.003AC847-C125710A.005A1B7D@avm.de>
From: s.schmidt@avm.de
Date: Fri, 3 Feb 2006 17:24:10 +0100
X-MIMETrack: Serialize by Router on ANIS1/AVM(Release 6.5.4FP2 | September 15, 2005) at
 03.02.2006 17:24:08
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
X-purgate-ID: 149429::060203172412-039CC00E-64BBA68F 0
X-purgate-Ad: Checked for SPAM by eleven - eXpurgate www.eXpurgate.net
X-purgate: clean
X-purgate: This mail is considered clean
X-purgate-type: clean
X-purgate-size: 1831/1750
X-AntiVirus: checked by AntiVir Milter (version: 1.1.0-4; AVE: 6.33.0.31; VDF: 6.33.0.199; host: mail.avm.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on January 15th / major change in USB subsystem and GPL_EXPORT_SYMBOL
declaration
Greg Kroah-Hartman added a Patch to kernel 2.6.15-git12, which
substantially changed the USB system.
The module "usb.c" is now a module named "driver.c" which exports its
symbols with EXPORT_SYMBOL_GPL:
-> usb_match_id; usb_register_driver; usb_deregister
Novell added the official kernel 2.6.16 incl. this patch to OSS 10.1 beta.

consequences
Because of the GPL_EXPORT declaration it is no longer possible to build and
run non-GPL loadable drivers for USB devices. We´ve put a lot of energy
into providing the open source community with Linux drivers for nearly all
of our products within the last six years. Today, the customer has the
option to choose Windows or Linux drivers for AVM USB products. AVM is the
market leader in the ISDN controller market with more than 80% market share
in Germany (close to 50% in Europe). Moreover AVM is one of a handful
manufacturers who provide a Linux driver for their WLAN USB devices.
Technically, there are a number of reasons, e.g. service quality and
reliability, to establish kernel mode drivers for communication devices
offering services like Fax G3, analog modem etc. by means of software.

conclusion
If it is no longer possible to have non-GPL USB drivers, we shall have to
drop our Linux support for all AVM USB devices. We would even have to
discontinue the 802.11g++ WLAN USB device driver Linux developement.

This mail is not intended to provoke a discussion of open vs closed source.
The only intention of this mail is to make you aware of the consequences of
such a decision.


Kind Regards
Sven Schmidt

AVM Audiovisuelles Marketing und Computersysteme GmbH
Alt-Moabit 95, 10559 Berlin, Germany
http://www.avm.de

