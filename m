Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268756AbUHaQFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268756AbUHaQFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268758AbUHaQFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:05:16 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:58349 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268756AbUHaQFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:05:05 -0400
From: Limin Gu <limin@dbear.engr.sgi.com>
Message-Id: <200408311604.i7VG4hn13358@dbear.engr.sgi.com>
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
To: guillaume.thouvenin@bull.net (Guillaume Thouvenin)
Date: Tue, 31 Aug 2004 09:04:43 -0700 (PDT)
Cc: guillaume.thouvenin@bull.net (Guillaume Thouvenin), jlan@sgi.com (Jay Lan),
       tim@physik3.uni-rostock.de (Tim Schmielau),
       corliss@digitalmages.com (Arthur Corliss),
       akpm@osdl.org (Andrew Morton), jlan@engr.sgi.com (Jay Lan),
       linux-kernel@vger.kernel.org (lkml), erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       kernel@ragnark.vestdata.no (Ragnar =?iso-8859-1?Q?Kj=F8rstad?=),
       y.ishikawa@soft.fujitsu.com (Yoshitaka ISHIKAWA)
In-Reply-To: <20040831102955.GA3540@frec.bull.fr> from "Guillaume Thouvenin" at Aug 31, 2004 12:29:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, Aug 31, 2004 at 11:06:47AM +0200, Guillaume Thouvenin wrote:
> > On Fri, Aug 27, 2004 at 12:55:03PM -0700, Jay Lan wrote:
> > > Please visit http://oss.sgi.com/projects/pagg/
> > > The page has been updated to provide information on a per job
> > > accounting project called 'job' based on PAGG.
> > > 
> > > There is one userspace rpm and one kernel  module for job.
> > > This may provide what you are looking for. It is a mature product
> > > as well. I am sure Limin(job) and Erik(pagg) would appreciate any
> > > input you can provide to make 'job' more useful.
> > 
> >   I have a question about job. If I understand how it works, you can not
> > add a process in a job. I mean when you start a session, a container is 
> > created and it's the only way to create it. If I'm right, I think that it 
> > could be interesting to add a process using ioctl and /proc interface.
> 
> I think that I'm not very clear. You can add a process to a container
> using the /proc/csa interface but it seems that currently this feature
> is not available with job-1.2.1 package. Therefore, maybe we can add a
> command called jattach that will attach a process to a given jid...

The current job package is job-1.4.0-1, you can find it at 
ftp://oss.sgi.com/projects/pagg/download

And it is correct that JOB_ATTACH ioctl is not implemented right now.
We could implement that ioctl and also add a user command like jattach.

We are trying to push the job kernel module to the community, but the ioctl
and /proc binary interface seems not an appropriate kernel and user space
communication interface. When job gets more users other CSA and there are
more interest about job, maybe we could request a new syscall number 
in linux. 

--Limin

> 
> Best,
> Guillaume
> 

