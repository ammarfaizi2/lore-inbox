Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVJaJgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVJaJgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 04:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVJaJgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 04:36:47 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:46784 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932341AbVJaJgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 04:36:45 -0500
Subject: Re: [patch 1/14] s390: statistics infrastructure.
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFBB1FC9BA.70D071A5-ONC12570AB.00342B9E-C12570AB.003B1DB2@de.ibm.com>
From: Martin Peschke3 <MPESCHKE@de.ibm.com>
Date: Mon, 31 Oct 2005 10:36:42 +0100
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 31/10/2005 10:36:43
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

> On Fri, Oct 28, 2005 at 04:06:17PM +0200, Martin Schwidefsky wrote:
> > From: Martin Peschke <mpeschke@de.ibm.com>
> >
> > [patch 1/14] s390: statistics infrastructure.
> >
> > Add the statistics facility. This features offers a simple way to
> > gather statistical data and to display them via the debugfs.
> > An example how this is used:
> >
> >          struct statistic_interface *stat_if;
> >          struct statistic *stat;
> >
> >          statistic_interface_create(&stat_if, "whatever");
> >          statistic_create(&stat, stat_if, "stat-name", "unit");
> >          statistic_define_value(stat, range_min, range_max, def_mode);
> >          ...
> >          statistic_inc(stat, value);         /* repeat.. */
> >          ...
> >          statistic_interface_remove(&stat_if);
>
> This certainly doesn't belong into arch code.  Please move to common
> code and send over to lkml for detailed review.

Sure, I am happy to do so.
I will try to answer Andrew's questions first, though. I think I will
want to pick up some of his suggestions prior to resubmission.

Thanks,
Martin

