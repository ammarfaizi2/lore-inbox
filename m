Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbTETUrf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 16:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbTETUrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 16:47:35 -0400
Received: from fmr01.intel.com ([192.55.52.18]:61151 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261166AbTETUre convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 16:47:34 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [Patch] e100 driver patch for 2.5 - option to restore old behavio r
Date: Tue, 20 May 2003 14:00:30 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010107D723@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] e100 driver patch for 2.5 - option to restore old behavio r
Thread-Index: AcMe+Ilda5jKCTMcQZ+Ewm/pxVke6gAF2u0g
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Downing, Thomas" <Thomas.Downing@ipc.com>, <linux-kernel@vger.kernel.org>
Cc: <jgarzik@mandrakesoft.com>, <akpm@digeo.com>, <davej@suse.de>,
       "Linux NICS" <linuxnics@mailbox.cps.intel.com>
X-OriginalArrivalTime: 20 May 2003 21:00:31.0285 (UTC) FILETIME=[D958BE50:01C31F12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These patches add a module parameter to restore older
> EEPROM behavior to the Intel e100 NIC driver.

We want the check to fail to detect mis-programmed eeproms.  The
checksum test isn't conclusive, but it does provide an indication
something is wrong.

> We have lots of boxen that for some reason always fail the 
> checksum, but the E100 NIC operates just fine. Others might 
> have the same issue.

The assumption is that the eeprom was programmed correctly in
manufacturing, so your nics were 1) mis-programmed during manufacturing,
or 2) modified later using some tool.  Follow-up with
linux.nics@intel.com to make sure 1) isn't the case.

-scott
