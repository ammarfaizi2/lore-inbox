Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266404AbVBFA00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266404AbVBFA00 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbVBFA0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:26:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17074 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265887AbVBFAUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:20:44 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Legacy IO spaces (was Re: [RFC] Reliable video POSTing on resume)
Date: Sat, 5 Feb 2005 16:19:57 -0800
User-Agent: KMail/1.7.2
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
References: <20050122134205.GA9354@wsc-gmbh.de> <200502041534.03004.jbarnes@engr.sgi.com> <9e47339105020516072b33a9c6@mail.gmail.com>
In-Reply-To: <9e47339105020516072b33a9c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502051619.57639.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, February 05, 2005 4:07 pm, Jon Smirl wrote:
> After thinking about this for a while I believe the solution is for
> bridges that implement a legacy space to export legacy_io/mem in
> sysfs. So in the ia64 world, all bridges would export these attributes
> since each bridge creates a unique legacy space.

Except some ia64 platforms don't have one legacy space per host bus like sn2 
does.

> Some questions...
> 1) Does the IA64 have child bridges that don't implement legacy space?

Yes, on sn2 each host<->pci bridge has two busses hanging off it, and each of 
them has its own legacy space.  Child bridges under that bus are routed 
according to the child bridge, which may not route legacy accesses.

> If so then they need to support VGA routing. What about Cardbus?

No ia64 boxes that I know of support cardbus.

> 2) Does an IA64 bridge supporting different legacy spaces alter the
> VGA io request to remove the offset and then send it out onto the bus?

Pretty much, yes.

> 3) How does all of this work with Opteron and Hypertransport?

Don't know, Andi probably does.

Jesse
