Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUBDEIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 23:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUBDEIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 23:08:38 -0500
Received: from kalmia.drgw.net ([209.234.73.41]:58075 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S266209AbUBDEIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 23:08:35 -0500
Date: Tue, 3 Feb 2004 22:08:34 -0600
From: Troy Benjegerdes <hozer@hozed.org>
To: "Woodruff, Robert J" <woody@co.intel.com>, bill.magro@intel.com
Cc: Greg KH <greg@kroah.com>, "Woodruff, Robert J" <woody@jf.intel.com>,
       infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Message-ID: <20040204040834.GF11222@kalmia.hozed.org>
References: <F595A0622682C44DBBE0BBA91E56A5ED1C3673@orsmsx410.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <F595A0622682C44DBBE0BBA91E56A5ED1C3673@orsmsx410.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think we need to wait for a vendor driver to put together a 2.6
IB access layer patch for review. I for one would like to see what
*just* the access layer, without anything else looks like.

Those of us with hardware know it works on 2.4 with a mellanox VPD.. the
real question is what the code looks like.

There are outstanding issues I've seen in performance testing related to
integration with the memory management subsystem.. if we integrate
directly into 2.6, we'll have the opportunity (but not the requirement) 
for more intelligent ways to deal locking and unlocking of memory.
I suspect that someone with more MMU-foo than myself will see some
intelligent way of useing the rmap changes.

In particular, I want someone paranoid about security to examine the
security model for allowing what processes get access to what IB card
resources.

On Tue, Feb 03, 2004 at 06:01:20PM -0800, Woodruff, Robert J wrote:
> Good I think the InfiniBand community would like to get some of the 
> code into 2.6. 
> 
> The access layer is all loadable modules and does not require any kernel
> changes. 
> But we will need to look into integrating it into the build environment 
> (and provide a patch for that). 
> 
> We will work with the InfiniBand HCA vendors, such as Mellanox and
> Fujitsu, to 
> get the 2.6 code tested on the hardware and put together a patch that
> can be submitted for review by the larger linux community. If you would
> like to see the code before we
> run it on 2.6, we could possibly do that as well. 
> 
> 
> woody
> 
> 
> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com] 
> Sent: Tuesday, February 03, 2004 5:03 PM
> To: Woodruff, Robert J
> Cc: Troy Benjegerdes; Woodruff, Robert J;
> infiniband-general@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
> the linux kernel
> 
> 
> On Tue, Feb 03, 2004 at 04:17:36PM -0800, Woodruff, Robert J wrote:
> > 
> > I heard from a friend of mine that 2.6 was closed to new features.
> > What sayith the community on allowing additional experimental drivers
> > (like the infiniband access layer) into 2.6 ? Can we still submit
> > something or do we have to wait till 2.7 ?
> 
> If it's a subsystem that does not touch any of the existing kernel (with
> the exception of adding it to the build and Kconfig), then it probably
> will not be a problem to add.
> 
> But then again, that all depends on what the code looks like, and none
> of us have seen that yet :)
> 
> thanks,
> 
> greg k-h

-- 
--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@hozed.org  

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's why
I draw cartoons. It's my life." -- Charles Shultz
