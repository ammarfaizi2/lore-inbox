Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUCaPDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 10:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbUCaPDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 10:03:48 -0500
Received: from mail.shareable.org ([81.29.64.88]:29844 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261998AbUCaPDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 10:03:47 -0500
Date: Wed, 31 Mar 2004 16:02:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Bill Davidsen <davidsen@tmr.com>, Len Brown <len.brown@intel.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Willy Tarreau <willy@w.ods.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Message-ID: <20040331150219.GC18990@mail.shareable.org>
References: <4069A359.7040908@nortelnetworks.com> <1080668673.989.106.camel@dhcppc4> <4069D3D2.2020402@tmr.com> <Pine.LNX.4.55.0403311305000.24584@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0403311305000.24584@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
>  Well, "cmpxchg", "xadd", etc. can be easily emulated with an aid of a
> spinlock.  With SMP operation included.

Nope.  Len Brown wrote:

> Linux uses this locking mechanism to coordinate shared access
> to hardware registers with embedded controllers,
> which is true also on uniprocessors too.

You can't do that with a spinlock.  The embedded controllers would
need to know about the spinlock.

-- Jamie
