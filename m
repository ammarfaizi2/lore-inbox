Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUBDEyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 23:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266213AbUBDEyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 23:54:23 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:19933 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S266193AbUBDEyT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 23:54:19 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Date: Tue, 3 Feb 2004 20:53:28 -0800
Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C3677@orsmsx410.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Thread-Index: AcPq1Js0PbQK5SG3Tg2+TrGDe0Ua+QABLk2g
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "Troy Benjegerdes" <hozer@hozed.org>,
       "Woodruff, Robert J" <woody@jf.intel.com>,
       "Magro, Bill" <bill.magro@intel.com>
Cc: "Greg KH" <greg@kroah.com>, "Woodruff, Robert J" <woody@jf.intel.com>,
       <infiniband-general@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Feb 2004 04:53:28.0953 (UTC) FILETIME=[D4BE7E90:01C3EADA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree we would not need to wait for a vendor driver to put something
together
that the community could start to review. I see what I can do to get
something
put together. 

-----Original Message-----
From: Troy Benjegerdes [mailto:hozer@hozed.org] 
Sent: Tuesday, February 03, 2004 8:09 PM
To: Woodruff, Robert J; Magro, Bill
Cc: Greg KH; Woodruff, Robert J;
infiniband-general@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
the linux kernel


I don't think we need to wait for a vendor driver to put together a 2.6
IB access layer patch for review. I for one would like to see what
*just* the access layer, without anything else looks like.

Those of us with hardware know it works on 2.4 with a mellanox VPD.. the
real question is what the code looks like.

There are outstanding issues I've seen in performance testing related to
integration with the memory management subsystem.. if we integrate
directly into 2.6, we'll have the opportunity (but not the requirement) 
for more intelligent ways to deal locking and unlocking of memory. I
suspect that someone with more MMU-foo than myself will see some
intelligent way of useing the rmap changes.

In particular, I want someone paranoid about security to examine the
security model for allowing what processes get access to what IB card
resources.

On Tue, Feb 03, 2004 at 06:01:20PM -0800, Woodruff, Robert J wrote:
> Good I think the InfiniBand community would like to get some of the
> code into 2.6. 
> 
> The access layer is all loadable modules and does not require any 
> kernel changes. But we will need to look into integrating it into the 
> build environment (and provide a patch for that).
> 
> We will work with the InfiniBand HCA vendors, such as Mellanox and 
> Fujitsu, to get the 2.6 code tested on the hardware and put together a

> patch that can be submitted for review by the larger linux community. 
> If you would like to see the code before we
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
> Subject: Re: [Infiniband-general] Getting an Infiniband access layer
in
> the linux kernel
> 
> 
> On Tue, Feb 03, 2004 at 04:17:36PM -0800, Woodruff, Robert J wrote:
> > 
> > I heard from a friend of mine that 2.6 was closed to new features. 
> > What sayith the community on allowing additional experimental 
> > drivers (like the infiniband access layer) into 2.6 ? Can we still 
> > submit something or do we have to wait till 2.7 ?
> 
> If it's a subsystem that does not touch any of the existing kernel 
> (with the exception of adding it to the build and Kconfig), then it 
> probably will not be a problem to add.
> 
> But then again, that all depends on what the code looks like, and none

> of us have seen that yet :)
> 
> thanks,
> 
> greg k-h

-- 
------------------------------------------------------------------------
--
Troy Benjegerdes                'da hozer'
hozer@hozed.org  

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best
answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Shultz
