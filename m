Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWAZU2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWAZU2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWAZU2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:28:00 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:24458 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932242AbWAZU2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:28:00 -0500
Date: Thu, 26 Jan 2006 21:27:59 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       "Alan Cox <alan@lxorguk.ukuu.org.uk> Dave Hansen" 
	<haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC: Multiple instances of kernel namespaces.
Message-ID: <20060126202758.GD20473@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
	"Alan Cox <alan@lxorguk.ukuu.org.uk> Dave Hansen" <haveblue@us.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Suleiman Souhlal <ssouhlal@FreeBSD.org>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Cedric Le Goater <clg@fr.ibm.com>
References: <1137522550.14135.76.camel@localhost.localdomain> <1137610912.24321.50.camel@localhost.localdomain> <1137612537.3005.116.camel@laptopd505.fenrus.org> <1137613088.24321.60.camel@localhost.localdomain> <1137624867.1760.1.camel@localhost.localdomain> <m1bqy6oevn.fsf_-_@ebiederm.dsl.xmission.com> <20060120201353.GA13265@sergelap.austin.ibm.com> <m13bjhoq1r.fsf@ebiederm.dsl.xmission.com> <20060126194755.GA20473@MAIL.13thfloor.at> <m1psmehhmu.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psmehhmu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 01:13:45PM -0700, Eric W. Biederman wrote:
> Herbert Poetzl <herbert@13thfloor.at> writes:
> 
> > On Sat, Jan 21, 2006 at 03:04:16AM -0700, Eric W. Biederman wrote:
> >> So in the simple case I have names like:
> >> 1178/1632
> >
> > which is a new namespace in itself, but it doesn't matter
> > as long as it uniquely and persistently identifies the
> > namespace for the time it exists ... just leaves the
> > question how to retrieve a list of all namespaces :)
> 
> Yes but the name of the namespace is still in the original pid namespace.
> And more importantly to me it isn't a new kind of namespace.
> 
> >> If I want a guest that can keep secrets from the host sysadmin I don't
> >> want transitioning into a guest namespace to come too easily.
> >
> > which can easily be achieved by 'marking' the namespace
> > as private and/or applying certain rules/checks to the
> > 'enter' procedure ...
> 
> Right.  The trick here is that you must be able to deny
> transitioning into a namespace from the inside the namespace.
> Or else a guest could never trust it.  Something one of my
> coworkers pointed out to me.

not necessarily, for example have a 'private' flag, which
can only be set once (usually from outside), ensuring that
the namespace will not be entered. this flag could be
checked from inside ...

best,
Herbert

> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
