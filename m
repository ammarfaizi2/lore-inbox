Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269133AbUIXPGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269133AbUIXPGa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUIXPG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:06:29 -0400
Received: from fmr06.intel.com ([134.134.136.7]:25757 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S268864AbUIXPDJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 11:03:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: suspend/resume support for driver requires an external firmware
Date: Fri, 24 Sep 2004 23:03:02 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD578D@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: suspend/resume support for driver requires an external firmware
Thread-Index: AcSiCMzRPTYS/lheRpG9AJQ6XOrbpQAPab2Q
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Patrick Mochel" <mochel@digitalimplant.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Sep 2004 15:03:03.0231 (UTC) FILETIME=[96F62CF0:01C4A247]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> We talked about this in Ottawa a few months ago, and I think
> this is the right approach. Note though, that I think it
> needs to be more complete:
> 
> - There needs to be restore_state() to be symmetic.
> - There needs to be the proper failure recovery
>   If save_state() or suspend() fails, every device that has had their
>   state saved needs to be restored.
> - It needs to be called for all power management requests.

Agreed.

> - The PCI implementation should call pci_save_state() in it,
> instead of in ->suspend().

Also agree. And split pci_restore_state() from ->resume to
->restore_state. But all current drivers need to be rewritten.

Thanks,
-yi
