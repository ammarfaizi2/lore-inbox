Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUBFEJG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 23:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266464AbUBFEJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 23:09:06 -0500
Received: from fmr09.intel.com ([192.52.57.35]:54757 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S266463AbUBFEI7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 23:08:59 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Thu, 5 Feb 2004 20:07:56 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE01B2BDD3@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Thread-Index: AcPsLs89w9yLLeYgQ3eZJ/EqsnTR3QAAxrlwAA0dx2A=
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Tillier, Fabian" <ftillier@infiniconsys.com>, "Greg KH" <greg@kroah.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, "Hefty, Sean" <sean.hefty@intel.com>,
       <linux-kernel@vger.kernel.org>, <hozer@hozed.org>,
       "Woodruff, Robert J" <woody@co.intel.com>,
       "Magro, Bill" <bill.magro@intel.com>, <woody@jf.intel.com>,
       <infiniband-general@lists.sourceforge.net>
X-OriginalArrivalTime: 06 Feb 2004 04:07:57.0287 (UTC) FILETIME=[CD5ED770:01C3EC66]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Tillier, Fabian
> ...
>
> Having atomic operations return a value allows one to do something like
> test for zero when decrementing an atomic variable such as a reference
> count, to determine whether final cleanup should proceed.  This removes
> the need for an actual spinlock protecting the reference count.  As you
> know, reading the value post-decrement does not guarantee that said
> value reflects the result of only that decrement operation.  It would be
> catastrophic if two threads checked the value of a reference count
> without proper synchronization - they could both end up running the
> cleanup code with undesired (and perhaps catastrophic) results.

atomic_dec_and_test() does just that (asm/atomic.h).

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
