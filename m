Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVASGuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVASGuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 01:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVASGuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 01:50:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:41651 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261604AbVASGt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 01:49:59 -0500
Date: Tue, 18 Jan 2005 22:49:57 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] consolidate arch specific resource.h headers
Message-ID: <20050118224957.I24171@build.pdx.osdl.net>
References: <20050118161056.H469@build.pdx.osdl.net> <20050119011950.GA15685@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050119011950.GA15685@ti64.telemetry-investments.com>; from brugolsky@telemetry-investments.com on Tue, Jan 18, 2005 at 08:19:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bill Rugolsky Jr. (brugolsky@telemetry-investments.com) wrote:
> On Tue, Jan 18, 2005 at 04:10:56PM -0800, Chris Wright wrote:
> > +#define INIT_RLIMITS					\
> > +{							\
> > +	{ RLIM_INFINITY, RLIM_INFINITY },		\
> > +	{ RLIM_INFINITY, RLIM_INFINITY },		\
> > +	{ RLIM_INFINITY, RLIM_INFINITY },		\
> > +	{      _STK_LIM, _STK_LIM_MAX  },		\
> > +	{             0, RLIM_INFINITY },		\
> > +	{ RLIM_INFINITY, RLIM_INFINITY },		\
> > +	{             0,             0 },		\
> > +	{      INR_OPEN,     INR_OPEN  },		\
> > +	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
> > +	{ RLIM_INFINITY, RLIM_INFINITY },		\
> > +	{ RLIM_INFINITY, RLIM_INFINITY },		\
> > +	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
> > +	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
> > +}
> 
> While you are rooting around in there, perhaps this block
> should be converted to C99 initializer syntax, to avoid
> problems if arch-specific changes are later introduced?

Yes, I had considered the same.  I had checked a couple arches and with
proper designated initializers, that bit would not need to be duplicated.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
