Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264030AbSIUAuN>; Fri, 20 Sep 2002 20:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275289AbSIUAuN>; Fri, 20 Sep 2002 20:50:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53006 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264030AbSIUAuM>;
	Fri, 20 Sep 2002 20:50:12 -0400
Message-ID: <3D8BC357.3080609@mandrakesoft.com>
Date: Fri, 20 Sep 2002 20:54:47 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rhoads, Rob" <rob.rhoads@intel.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux [add-more-silly-APIs] Device Drivers Project
References: <D9223EB959A5D511A98F00508B68C20C0A53899F@orsmsx108.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rhoads, Rob wrote:
> Project Announcement:
> --------------------
> We've started a new project on sourceforge.net w/ focus 
> on hardening Linux device drivers for highly available 
> systems. This project is being worked on with folks from 
> OSDL's CGL and DCL projects as well.

[...]
> Hardened Driver Project Overview:
> --------------------------------
> Device drivers have traditionally been a significant source 
> of software faults. For this reason, they are of key concern
> in improving the availability and stability of the operating
> system. A critical element in creating Highly Available (HA)
> environment is to reduce the likelihood of faults in key 
> drivers, a methodology called driver hardening. 
[...]
> To minimize instability contributed by device drivers and to 
> enhance the availability of HA systems, we've attempted to 
> define a set of requirements that a device driver should 
> adhere to in order to be considered a hardened driver. We 
> then define different hardening traits and the required 
> programming interfaces to support these hardening traits.
> 
> We've identified four areas in which drivers can be hardened:
> o Hardening with code robustness
> o Hardening with event logging
> o Hardening with diagnostics
> o Hardening with resource monitoring and statistics
> 
> We've also identified some key areas we feel are most critical
> to overall system stability and plan to focus initial hardening 
> efforts on drivers for network interface cards, physical storage, 
> and logical storage.


Sigh.

While the goal is certainly good and true, the implementation really stinks.

You simply cannot "harden" drivers by adding additional statistics nor 
by printing diagnostic messages via printk().  Further, centralizing 
--domain-specific-- diagnostics and statistics is just plain moving in 
the wrong direction.

Hardening drivers is a __human__ problem.  People use existing APIs and 
fuck up, thus creating bugs.  You are attempting to paper it over with 
buzzword-compliant features, but not actually addressing the real 
problem.  Adding silly APIs does not fix this.  You can't avoid getting 
down and dirty and actually fixing the drivers, and fixing up the 
_existing_ APIs so that humans create fewer bugs.

I fully support hardening, and "carrier grade linux."  This just ain't 
the way to do it.

[no offense intended.  if you think my comments harsh, wait until Al 
Viro sees your sample driver...]

	Jeff



