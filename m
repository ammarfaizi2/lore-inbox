Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWJXDsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWJXDsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 23:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWJXDsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 23:48:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:23985 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965077AbWJXDsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 23:48:46 -0400
Subject: Re: Battery class driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Shem Multinymous <multinymous@gmail.com>,
       David Zeuthen <davidz@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       olpc-dev@laptop.org, greg@kroah.com, len.brown@intel.com,
       sfr@canb.auug.org.au
In-Reply-To: <20061024032704.GA24320@srcf.ucam.org>
References: <1161627633.19446.387.camel@pmac.infradead.org>
	 <1161641703.2597.115.camel@zelda.fubar.dk>
	 <41840b750610231956ib1c7204tafb23ecd76f5d9d2@mail.gmail.com>
	 <20061024032704.GA24320@srcf.ucam.org>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 13:48:27 +1000
Message-Id: <1161661707.10524.547.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-24 at 04:27 +0100, Matthew Garrett wrote:
> On Tue, Oct 24, 2006 at 04:56:30AM +0200, Shem Multinymous wrote:
> 
> > 30 seconds? I've seen battery applets that poll 1sec intervals (that's
> > actually useful when you tweak power saving). And for things like the
> > hdaps accelerometer driver, we're at the 50HZ region.
> 
> Reading the battery status has the potential to call an SMI that might 
> take an arbitrary period of time to return, and we found that having 
> querying at around the 1 second mark tended to result in noticable 
> system performace degredation.
> 
> Possibly it would be useful if the kernel could keep track of how long 
> certain queries take? That would let userspace calibrate itself without 
> having to worry about whether it was preempted or not.
> 
> > You can't require reading battery status to be a root-only operation.
> 
> We certainly can. Whether we want to is another matter :) I tend to 
> agree that moving to a setup that makes it harder for command-line users 
> to read the battery status would be a regression.

I think it's up to the backend to poll more slowly and cache the results
on those machines then.

Ben.


