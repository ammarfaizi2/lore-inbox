Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264552AbTEPSjL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTEPSjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:39:10 -0400
Received: from palrel10.hp.com ([156.153.255.245]:19331 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264552AbTEPSjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:39:08 -0400
Date: Fri, 16 May 2003 11:49:20 -0700
To: Oliver Neukum <oliver@neukum.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030516184920.GA26221@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030515200324.GB12949@ranty.ddts.net> <200305161007.31335.oliver@neukum.org> <20030516095624.GA30397@ranty.ddts.net> <200305161753.17198.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305161753.17198.oliver@neukum.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 05:53:17PM +0200, Oliver Neukum wrote:
> >
> >  Hotpluggability is not required, it is the same for any module, which
> >  gets loaded while the system is running. Drivers don't even need to be
> >  aware of hotplug.
> 
> In that case they can contain the firmware and mark it __init.
> They need no RAM. They can even mark the code needed to put
> firmware into the device as __init.

	I think you missed a lot of the previous discussion. Many high
level kernel developpers (Jeff, Alan, Greg) have said 'niet' to binary
firmware linked with the kernel (unless there is source code
available). Please assume that all drivers currently including
firmware blobs in the kernel will need fixing and therefore should not
be taken as example.
	The threads :
		http://marc.theaimsgroup.com/?t=105222131600002&r=1&w=2
		http://marc.theaimsgroup.com/?t=105045487300002&r=1&w=2
		http://marc.theaimsgroup.com/?t=105181861200001&r=1&w=2
		http://marc.theaimsgroup.com/?t=105295022700002&r=1&w=2
		http://marc.theaimsgroup.com/?t=105302951900003&r=1&w=2
	Yes, that's a lot to read, but this will explain the full
complexity of the situation.

> An awful lot of overhead.

	It's not like we have a choice on this issue. The embedded
people are already grumbling.

> 	Regards
> 		Oliver

	Jean
