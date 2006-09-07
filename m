Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWIGXGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWIGXGe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWIGXGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:06:34 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:19170 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422685AbWIGXGd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:06:33 -0400
Date: Thu, 7 Sep 2006 18:06:30 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060907230630.GA15538@sergelap>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906182531.GA24670@sergelap.austin.ibm.com> <20060906222731.GA10675@clipper.ens.fr> <20060907000441.GA22240@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907000441.GA22240@clipper.ens.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Madore (david.madore@ens.fr):
> On Thu, Sep 07, 2006 at 12:27:31AM +0200, David Madore wrote:
> > On Wed, Sep 06, 2006 at 01:25:31PM -0500, Serge E. Hallyn wrote:
> > > I'd recommend you split this patch into at least 3:
> > > 	1. move to 64-bit caps
> > > 	2. introduce your new caps
> > > 		(perhaps even one new cap per patch)
> > > 	3. introduce the new inheritance rules
> > 
> > Yes, that sounds like a good idea.  I'll do that.
> 
> Done.  Attached.  Except that the order is
> 
> part1: move to 64-bit caps (and also re-enable CAP_SETPCAP),
>        where upper 32-bits are "regular" capabilities (but none defined)
> 
> part2: introduce the new inheritance rules
> 
> part3: introduce new ("regular") capabilities

Thanks.  This made comparing the inh behavior to your web page and to
the classic code much easier.

I'm not sure reserving all 32 for 'regular' caps is the way
to go, since we're about to overflow the 32 bits of sysadm caps
already.  What about maybe 20 regular caps?

No need to do this now for my sake, but if you repost these, doing so
in 3 separate emails with the patches inline will make it more likely
that people read them.

thanks,
-serge
