Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUDBKyK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 05:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUDBKyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 05:54:10 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:5074 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261728AbUDBKyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 05:54:07 -0500
Date: Fri, 2 Apr 2004 12:54:06 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Len Brown <len.brown@intel.com>
Cc: Jamie Lokier <jamie@shareable.org>, Bill Davidsen <davidsen@tmr.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Willy Tarreau <willy@w.ods.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
In-Reply-To: <1080852371.30349.19.camel@dhcppc4>
Message-ID: <Pine.LNX.4.55.0404021252100.4735@jurand.ds.pg.gda.pl>
References: <4069A359.7040908@nortelnetworks.com>  <1080668673.989.106.camel@dhcppc4>
 <4069D3D2.2020402@tmr.com>  <Pine.LNX.4.55.0403311305000.24584@jurand.ds.pg.gda.pl>
  <20040331150219.GC18990@mail.shareable.org>  <Pine.LNX.4.55.0404011423070.3675@jurand.ds.pg.gda.pl>
 <1080852371.30349.19.camel@dhcppc4>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Len Brown wrote:

> ACPI specifies a location in regular memory that is used to contain the
> lock.  The lock is used both by the CPU and by the embedded controller
> to cover access to shared registers.  We don't spin on this lock because
> we don't know how long the embedded controller might hold it.  Instead
> when we fail to acquire it we schedule an event to trigger when the lock
> is free.

 OK, that's clear to me now.  Then does this lock really require
"cmpxchg"?  Wouldn't a lone "xchg" suffice?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
