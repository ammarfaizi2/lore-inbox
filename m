Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWEWGL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWEWGL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 02:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWEWGL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 02:11:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4552 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932091AbWEWGL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 02:11:59 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: i386 Kconfig options out of order
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 May 2006 16:10:20 +1000
Message-ID: <9451.1148364620@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Options NUMA and EFI in arch/i386/Kconfig depend on ACPI but they
appear before the ACPI option.  make oldconfig with no initial setting
for CONFIG_ACPI will prompt for these options, but if you then say No
to CONFIG_ACPI the options will silently be turned off.  Conversely if
you turn on CONFIG_ACPI you do not get prompted for the options that
are out of order.

