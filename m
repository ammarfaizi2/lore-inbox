Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWELVzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWELVzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWELVzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:55:04 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16003 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932253AbWELVzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:55:02 -0400
Date: Fri, 12 May 2006 14:57:56 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 26/35] Add Xen subarch reboot support
Message-ID: <20060512215756.GE2697@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085158.282993000@sous-sol.org> <200605091902.31327.ak@suse.de> <20060512214655.GC4189@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512214655.GC4189@ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek (pavel@suse.cz) wrote:
> Hi!
> 
> > > +
> > > +/* Ignore multiple shutdown requests. */
> > > +static int shutting_down = SHUTDOWN_INVALID;
> > > +static void __shutdown_handler(void *unused);
> > > +static DECLARE_WORK(shutdown_work, __shutdown_handler, NULL);
> > > +
> > > +static int shutdown_process(void *__unused)
> > > +{
> > > +	static char *envp[] = { "HOME=/", "TERM=linux",
> > > +				"PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
> > > +	static char *poweroff_argv[] = { "/sbin/poweroff", NULL };
> > 
> > This should be configurable, probably in a sysctl
> 
> Actually we have similar code in sparc and acpi parts, IIRC. We
> probably want to have one, common, shut-me-off routine.

Yep, I had that cleanup in mind, the patch said:

TODO:
 - move poweroff and halt to generic similar to c_a_d

thanks,
-chris
