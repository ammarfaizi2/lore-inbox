Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVGBKVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVGBKVf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 06:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVGBKVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 06:21:35 -0400
Received: from femail.waymark.net ([206.176.148.84]:37087 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261848AbVGBKUk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 06:20:40 -0400
Date: 2 Jul 2005 06:57:54 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: 2.6.13-rc1-git2 Oops on rmmod serial_core
To: linux-kernel@vger.kernel.org
Message-ID: <503fc0.e20f3b@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serial support code newly allows selecting the max number of serial
ports. This computer has one s-port so i typed '1'.

 config SERIAL_8250_NR_UARTS
 int "Maximum number of 8250/16550 serial ports"
 depends on SERIAL_8250
 default "4"
 help
 Set this to the number of serial ports you want the driver
 to support.  This includes any ports discovered via ACPI or
 PCI enumeration and any ports that may be added at run-time
 via hot-plug, or any ISA multi-port serial cards.

I found the value needs to be at least '4' or we oops at rmmod
serial_core.  2.6.13-rc1-git2 kernels with values from one through four
were tested.
--
All progress is based upon a universal innate desire on the part of
every organism to live beyond its income.
                -- Samuel Butler
--- MultiMail/Linux v0.46
