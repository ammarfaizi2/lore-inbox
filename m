Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbTDWULH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTDWULG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:11:06 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:4109 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264253AbTDWUKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:10:01 -0400
Date: Wed, 23 Apr 2003 21:22:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mika Kukkonen <mika@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cgl_discussion@osdl.org
Subject: Re: [cgl_discussion] Re: OSDL CGL-WG draft specs available for review
Message-ID: <20030423212208.B7383@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mika Kukkonen <mika@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
	cgl_discussion@osdl.org
References: <1051044403.1384.44.camel@miku-t21-redhat.koti> <20030423174958.A2603@infradead.org> <1051122743.7515.97.camel@miku-t21-redhat.koti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051122743.7515.97.camel@miku-t21-redhat.koti>; from mika@osdl.org on Wed, Apr 23, 2003 at 11:32:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 11:32:25AM -0700, Mika Kukkonen wrote:
> On Wed, 2003-04-23 at 09:49, Christoph Hellwig wrote:
> > >    4.10 Force unmount (2) 2 Experimental Availability Core
> (...)
> > This is very hard to get right.  What the expermintel implementation
> > you're referring to?
> 
> This feature was mentioned in v1.1 spec, so some distributions already
> provide "experimental" versions of this feature. There are no Open
> Source projects I know of, though.

How do they provide  "experimental" versions of this feature?  I don't
see how this can be done without major fileystem surgery, so it
kindof must be an OSS implementation..

> > Without really big kernel changes it's hard to get full POSIX thread
> > semantics. e.g. we still don't have credential sharing for tasks.  And
> > it doesn't lool like this makes 2.6.  I'd rather remove this one..
> 
> Ah, we are not aiming to get our features into a certain kernel version,
> and actually we do not expect or even want (because of 2.6
> stabilization) that our v2 spec kernel features get merged into 2.6 at
> this point of time (some of them might, though).
> 
> For us it is enough that the distros will pick most of the features
> after v2 specs get released and through that adaption some of
> those features will get merged into 2.7 or whatever is coming after 2.6.
> So we are not in hurry ;-)

Well, this is not doable ontop of any existing kernel without major
suregery (introducing a credential cache and passing it down to
every place that's doing uid/gid based access control).

So none of the CGL distros can really support that.

