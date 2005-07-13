Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVGMAtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVGMAtV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVGMAtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:49:20 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:60941 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262448AbVGMAtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:49:14 -0400
X-IronPort-AV: i="3.94,192,1118034000"; 
   d="scan'208"; a="265561350:sNHT23393360"
Date: Tue, 12 Jul 2005 19:57:16 -0500
From: Doug Warzecha <Douglas_Warzecha@dell.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: Add Dell Systems Management Base driver
Message-ID: <20050713005716.GA15298@sysman-doug.us.dell.com>
References: <20050706001333.GA3569@sysman-doug.us.dell.com> <20050706041702.GA10253@kroah.com> <20050706155734.GA4271@sysman-doug.us.dell.com> <20050706160737.GC13115@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706160737.GC13115@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 11:07:37AM -0500, Greg KH wrote:
>    On Wed, Jul 06, 2005 at 10:57:35AM -0500, Doug Warzecha wrote:
>    > On Tue, Jul 05, 2005 at 11:17:03PM -0500, Greg KH wrote:
>    > >
>    > >    I'm sure I commented on this driver already, yet, I never got a
>    response
>    > >    and the code is not changed.  Is there some reason for this? 
>    That's a
>    > >    sure way to prevent your patch from ever being applied...
>    >
>    > This is the first comment on the release function.  The code has been
>    > changing in response to comments from you and others.  We'll continue
>    > to make changes as needed.
> 
>    You never responded to those questions though, so determining if the
>    code was changed is difficult.  And I still see you using ioctls, which,
>    if I remember, was what I asked about.
> 

The dcdbas driver has been shipping outside of the kernel tree for some time now in support of the systems listed in the source and is expected to support the listed systems for some time to come.  The driver has always used ioctls for Dell systems management software to communicate with it.  The systems that are supported by the driver are older Dell PowerEdge systems which contain Dell proprietary hardware systems management interfaces.  The latest shipping PowerEdge systems support the standard IPMI hardware systems management interface which can be accessed by the in-kernel standard IPMI driver (which uses ioctls).  Future PowerEdge systems are expected to support the IPMI systems management interface as well.

Even though the dcdbas driver is not expected to be needed for future PowerEdge systems, we would like to make it easier for Dell customers to run Dell systems management software with the latest kernel on the systems supported by the dcdbas driver by making the driver available in the kernel tree.  We would like to do that without impacting the existing Dell systems management software for the older systems so that we can focus our resources on the newer systems.

Is it an absolute "must" that this driver not use ioctls?

Doug
