Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267205AbUG1XTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbUG1XTR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUG1XPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:15:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40120 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267205AbUG1XNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:13:55 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<200407280903.37860.jbarnes@engr.sgi.com>
	<m1bri06mgw.fsf@ebiederm.dsl.xmission.com>
	<200407281106.17626.jbarnes@engr.sgi.com>
	<20040728124405.1a934bec.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 17:11:53 -0600
In-Reply-To: <20040728124405.1a934bec.akpm@osdl.org>
Message-ID: <m1pt6f681y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> >
> > On Wednesday, July 28, 2004 11:00 am, Eric W. Biederman wrote:
> > > > I think this could end up being a good thing.  It gives more people a
> > > > stake in making sure that driver shutdown() routines work well.
> > >
> > > Which actually is one of the items open for discussion currently.
> > > For kexec on panic do we want to run the shutdown() routines?
> > 
> > We'll have to do something about incoming dma traffic and other stuff that the
> 
> > devices might be doing.  Maybe a arch specific callout to do some chipset 
> > stuff?
> > 
> 
> Does ongoing DMA actually matter?  After all,the memory which is being
> dma-ed into is pre-reserved and allocated for that purpose, and the dump
> kernel won't be using it.

If we can ensure the addresses where the new kernel will run will never
have DMA pointed at them I actually don't think so.  This is why last
year I recommended building a kernel that runs at a non-default address
and finding a way to simply preload it there.

Eric
