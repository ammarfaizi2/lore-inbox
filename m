Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935788AbWK1KCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935788AbWK1KCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935789AbWK1KCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:02:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:13013 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S935788AbWK1KCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:02:54 -0500
X-Authenticated: #14349625
Subject: Re: [patch] PM: suspend/resume debugging should depend on
	SOFTWARE_SUSPEND
From: Mike Galbraith <efault@gmx.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@suse.cz>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1164516833.6543.0.camel@Homer.simpson.net>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	 <Pine.LNX.4.64.0611240959170.6991@woody.osdl.org>
	 <1164463898.6221.24.camel@Homer.simpson.net>
	 <200611251812.53246.rjw@sisk.pl>
	 <1164516833.6543.0.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 11:01:50 +0100
Message-Id: <1164708110.6021.12.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-26 at 05:53 +0100, Mike Galbraith wrote:
> On Sat, 2006-11-25 at 18:12 +0100, Rafael J. Wysocki wrote:
> 
> > Hm, could you please file a bugzilla report regarding the serial console for
> > the information of its maintainer(s)?
> 
> Yeah, I'll rummage around a bit first though.

The serial console appears to be innocent.  The suspend/resume methods
for my 16550A serial port aren't even being _called_, apparently because
pnp swiped ttyS0.  Disabling pnp support, the port suspends and resumes
just peachy.  /sys has a different layout without pnp enabled.  With it,
there are platform/ttyS[1-3] entries, but ttyS0 is in pnp.  Without pnp
support, the platform/ttyS* entries are gone, as is of course pnp/ttyS0.

I guess I'll have to switch "rummage" directories.

	-Mike

