Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbUCOUHr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 15:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbUCOUHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 15:07:47 -0500
Received: from mail.cyclades.com ([64.186.161.6]:6109 "EHLO intra.cyclades.com")
	by vger.kernel.org with ESMTP id S262741AbUCOUHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 15:07:45 -0500
Date: Mon, 15 Mar 2004 17:06:37 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: "Cress, Andrew R" <andrew.r.cress@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Yury V. Umanets" <umka@namesys.com>,
       "Guo, Min" <min.guo@intel.com>,
       =?iso-8859-2?Q?Tvrtko_A=2E_Ur=B9ulin?= <tvrtko@croadria.com>,
       <linux-kernel@vger.kernel.org>, <cgl_discussion@lists.osdl.org>
Subject: RE: [cgl_discussion] Re: About Replaceable OOM Killer
In-Reply-To: <E5DA6395B8F9614EB7A784D628184B200E34E8@hdsmsx402.hd.intel.com>
Message-ID: <Pine.LNX.4.44.0403151705200.2855-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yury, others,

I do think the a "replaceable OOM killer" is a valid and useful thing. 

You should change your efforts to make such a feature be accepted in 2.6,
though.

On Mon, 15 Mar 2004, Cress, Andrew R wrote:

> Right, once it is really OOM, you are SOL :-)  Really the only thing you can do at this point in the kernel is to not allocate any more memory, and functions that require more memory just don't work, and the recovery is to reboot..
> 
> IMO, the best answer is to detect a nearly-OOM, or trending-toward-OOM condition before it gets so bad.
> This would allow userland actions, but would require more customization to tune the detection criteria, which would also imply a userland implementation of the monitoring.  We've found that PCP works pretty well for this type of thing.
> See http://oss.sgi.com/projects/pcp/ and http://pcp4cgl.sourceforge.net/.  We did some work with this for CGL 1.0.
> 
> Andy Cress
> 
> -----Original Message-----
> From: cgl_discussion-bounces@lists.osdl.org [mailto:cgl_discussion-bounces@lists.osdl.org] On Behalf Of Pavel Machek
> Sent: Monday, March 08, 2004 6:02 AM
> To: Yury V. Umanets
> Cc: Guo, Min; Tvrtko A. Ur¹ulin; linux-kernel@vger.kernel.org; cgl_discussion@lists.osdl.org
> Subject: [cgl_discussion] Re: About Replaceable OOM Killer
> 
> 
> Hi!
> 
> > > Though it hasn't been updated for a while because nobody cares...
> > IMHO problem with OOM killer is that it always will do wrong choice. So,
> > it should be either plugin based or allow to configure it and this
> > means, that it will become more complex and buggy. Does not it mean,
> > that OOM killer should be moved to user space?
> > 
> > How about to export OOM event to user space? It might be done in manner
> > like hotplug script is used.
> 
> When you are OOM, you really can't exec userland script...
> 
> 

