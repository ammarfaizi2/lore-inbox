Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTE2UKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTE2UKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:10:06 -0400
Received: from smtp-out-01.utu.fi ([130.232.202.171]:60810 "EHLO
	smtp-out-01.utu.fi") by vger.kernel.org with ESMTP id S262598AbTE2UKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:10:05 -0400
Date: Thu, 29 May 2003 23:23:22 +0300
From: =?iso-8859-1?Q?Tero_J=E4nk=E4?= <tesaja@utu.fi>
Subject: Generic PCI IDE Chipset Support in 2.4.21-rc6
To: linux-kernel@vger.kernel.org
Message-id: <20030529202322.GA6441@tron.yok.utu.fi>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A possible bug here. At least a 'bug' in the documentation if nothing else.

In menuconfig there are the following two entries:

[*]   PCI IDE chipset support
[ ]     Generic PCI IDE Chipset Support (NEW)

The help (?) for "PCI IDE chipset support" in menuconfig shows:

CONFIG_BLK_DEV_IDEPCI:

Say Y here for PCI systems which use IDE drive(s).
This option helps the IDE driver to automatically detect and
configure all PCI-based IDE interfaces in your system.


However in Documentation/Configure.help it says about CONFIG_BLK_DEV_IDEPCI:

Generic PCI IDE chipset support
CONFIG_BLK_DEV_IDEPCI
  Say Y here for PCI systems which use IDE drive(s).
  This option helps the IDE driver to automatically detect and
  configure all PCI-based IDE interfaces in your system.


Notice the first line, "Generic PCI IDE chipset support", and this was
supposed to be help for "PCI IDE chipset support" (at least if menuconfig is
to be trusted).

There is no help (?) available for "Generic PCI IDE Chipset Support" at all
in menuconfig. And no references to CONFIG_BLK_DEV_GENERIC in
Documentation/Configure.help.

What is the purpose of "Generic PCI IDE Chipset Support" (CONFIG_BLK_DEV_GENERIC)?
When should it be enabled and when not?

When upgrading from 2.4.20, CONFIG_BLK_DEV_GENERIC is disabled by default,
even though CONFIG_BLK_DEV_IDEPCI is enabled. Is this how it should be?

I'd appreciate if any responses are cc:ed to me, since I'm not in the lkml.

-- 
Tero Jänkä
