Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266570AbUBEToT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266564AbUBEToT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:44:19 -0500
Received: from gw0.infiniconsys.com ([65.219.193.226]:41223 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S266570AbUBEToI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:44:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in the Linux kernel
Date: Thu, 5 Feb 2004 14:44:07 -0500
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96C2@mercury.infiniconsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in the Linux kernel
Thread-Index: AcPsF4/hx0cPNx+HT5miYWKkvxL6wwAAY87w
From: "Tillier, Fabian" <ftillier@infiniconsys.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Hefty, Sean" <sean.hefty@intel.com>, <linux-kernel@vger.kernel.org>,
       "Troy Benjegerdes" <hozer@hozed.org>,
       "Woodruff, Robert J" <woody@co.intel.com>,
       "Magro, Bill" <bill.magro@intel.com>,
       "Woodruff, Robert J" <woody@jf.intel.com>,
       <infiniband-general@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

The component library (the abstraction layer used by IBAL) is in no way
tied to InfiniBand.  Whatever is in there can be used by any other
projects, and there's a lot of useful stuff in there that does provide
value.
 
One goal of IBAL is to get InfiniBand support for Linux.  As such, it is
a higher priority to get things working than to wait for changes to
appear in the Linux kernel before making forward progress.

Keep in mind also that InfiniBand is not a Linux-only technology.
Sharing code between different operating systems accelerates development
and reduces the cost of maintenance.

Lastly, there are things (like timers) that are blatantly missing from
user-mode in Linux, and having an abstraction here allows code to be
shared between kernel and user mode.

Keep in mind that we're not expecting you or the Linux community to
blindly take the code as is.  We're looking for constructive feedback to
make it so that everyone goes home happy.  It's disappointing that the
feedback we're getting from you is that any abstractions will be cause
for rejection.  What are the grounds for this policy?  What does it
accomplish?  Is portable code a problem for the Linux community in
general?  Removing the abstraction from the IBAL project would require
significant rework of the code that would add very little from a
functional perspective, and make the code base more complicated and
harder to maintain.

I think it would help us a lot to understand the motivation behind your
opinions so that we can try to meet your expectations.  If I've
misinterpreted your opinions, please clarify.

Thanks,

- Fab

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Thursday, February 05, 2004 10:41 AM
To: Tillier, Fabian
Cc: Hefty, Sean; linux-kernel@vger.kernel.org; Troy Benjegerdes;
Woodruff, Robert J; Magro, Bill; Woodruff, Robert J;
infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
the Linux kernel

On Thu, Feb 05, 2004 at 01:31:45PM -0500, Tillier, Fabian wrote:
> 
> Are you suggesting that if there is any abstraction, the code will
never
> be accepted?  Or rather that the abstraction better be correct?  I'm
> hoping for the latter, however please clarify.

The kernel has its own abstractions that seem to be working quite well
for all different types of platforms.  There is no need for you to
create your own, just for a driver subsystem.

If you have found any problems with the current locks please let the
entire kernel community benefit from your changes, and not relegate them
to a infiniband-only section of the kernel.

So yes, if you add your own versions of spinlocks and atomic_t types,
your code will be rejected, among other things :)

thanks,

greg k-h
