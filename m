Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbVG2VK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVG2VK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbVG2VIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:08:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53702 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262842AbVG2VIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:08:06 -0400
Date: Fri, 29 Jul 2005 14:07:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Michael Kerrisk <mtk-manpages@gmx.net>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net, akpm@osdl.org
Subject: Re: Broke nice range for RLIMIT NICE
Message-ID: <20050729210756.GK19052@shell0.pdx.osdl.net>
References: <32710.1122563064@www32.gmx.net> <20050729061318.GD7425@waste.org> <20050729201836.GH19052@shell0.pdx.osdl.net> <20050729205120.GJ19052@shell0.pdx.osdl.net> <1122670930.9381.25.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122670930.9381.25.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Fri, 2005-07-29 at 13:51 -0700, Chris Wright wrote:
> > * Chris Wright (chrisw@osdl.org) wrote:
> > > Yes, this requires updated pam patch.
> > 
> > Here's the updated pam patch.  I left the lower end at 0 rather than 1,
> > since it's no harm.
> >  
> > +/* Hack to test new rlimit values */
> 
> Does this still apply?  If so what would a better solution look like?

The better solution is to make sure you have new enough glibc-kernheaders
to pick up those values directly from resource.h and drop that hunk.  On
my systems, it's still needed even with rawhide headers.

thanks,
-chris
