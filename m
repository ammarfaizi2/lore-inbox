Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUI1VEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUI1VEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUI1VEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:04:31 -0400
Received: from fmr05.intel.com ([134.134.136.6]:9673 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S267785AbUI1VE3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:04:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.9-rc2-mm4 e100 enable_irq unbalanced from
Date: Tue, 28 Sep 2004 14:03:56 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF6375@orsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.9-rc2-mm4 e100 enable_irq unbalanced from
Thread-Index: AcSkx7A6Zk7HejZdSDSQLQl0m5f8+gA1lV1A
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Paul Fulghum" <paulkf@microgate.com>,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Sep 2004 21:03:58.0297 (UTC) FILETIME=[AC0A0490:01C4A59E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I suspect the correct thing is to remove
> disable_irq/enable_irq from e100_up.
> I don't see any purpose for these calls in e100_up.

I don't either!  This doesn't look right to me at all.  

These enable_irq/disable_irq calls got added recently to -mm, probably
in the fix-for-spurious-interrupts-on-e100-resume-2.patch.  Maybe just
the disable_irq call is all that is needed to solve the spurious
interrupt case?

Ganesh, can we back out patch out of -mm and go back to the drawing
board on the original problem?  This patch will cause problems.

-scott
