Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbVKOJcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbVKOJcX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVKOJcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:32:22 -0500
Received: from ns.firmix.at ([62.141.48.66]:10114 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751412AbVKOJcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:32:20 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Bernd Petrovitsch <bernd@firmix.at>
To: Robert Hancock <hancockr@shaw.ca>
Cc: ndiswrapper-general@lists.sourceforge.net,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43796489.8090500@shaw.ca>
References: <58XuN-29u-17@gated-at.bofh.it> <58XuN-29u-19@gated-at.bofh.it>
	 <58XuN-29u-21@gated-at.bofh.it> <58XuN-29u-23@gated-at.bofh.it>
	 <58XuN-29u-25@gated-at.bofh.it> <58XuN-29u-15@gated-at.bofh.it>
	 <58YAt-3Fs-5@gated-at.bofh.it> <58ZGo-5ba-13@gated-at.bofh.it>
	 <5909m-5JB-5@gated-at.bofh.it> <43795F35.3050904@shaw.ca>
	 <43795C55.9080305@wolfmountaingroup.com>  <43796489.8090500@shaw.ca>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 15 Nov 2005 10:31:58 +0100
Message-Id: <1132047119.27192.14.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 22:31 -0600, Robert Hancock wrote:
> Jeff V. Merkey wrote:
> > What?  There's more kernel apps than just ndis network drivers that get 
> > ported.  ndiswrapper is busted (which is used for a lot of laptops)
> > without 4K stacks.
> 
> Which is why ndiswrapper needs to get fixed to work with 4K stacks. 
> ndiswrapper is the thing that's doing the wierd stuff, it needs to adapt 
> to the kernel, not the other way around. The reasons to use 4K stacks 
> are strong enough that they are not made up for by the fact that 
> ndiswrapper currently would like to have more stack space.

There was a discussion weeks (or already months?) ago about this. The
ndiswrapper maintainer had no problem with private stacks for the NDIS
drivers but IIRC there where some issues with callbacks from the NDIS
drivers which led to the conclusion that it's way too much of a hassle
to get it working and stable.
And yes, you need ndiswrapper for almost all of the WLAN drivers since
there is no documentation of them.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

