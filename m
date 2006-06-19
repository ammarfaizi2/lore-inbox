Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWFSNoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWFSNoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 09:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWFSNoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 09:44:10 -0400
Received: from palrel12.hp.com ([156.153.255.237]:25045 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S932456AbWFSNoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 09:44:08 -0400
Date: Mon, 19 Jun 2006 06:36:26 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/16] 2.6.17-rc6 perfmon2 patch for review: new sysfs support
Message-ID: <20060619133626.GE25215@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606172339_MC3-1-C2C6-D2C3@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606172339_MC3-1-C2C6-D2C3@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

On Sat, Jun 17, 2006 at 11:36:36PM -0400, Chuck Ebbert wrote:
> In-Reply-To: <200606150907.k5F97YtU008130@frankl.hpl.hp.com>
> 
> On Thu, 15 Jun 2006 02:07:34 -0700, Stephane Eranian wrote:
> 
> > --- linux-2.6.17-rc6.orig/perfmon/perfmon_sysfs.c     1969-12-31 16:00:00.000000000 -0800
> > +++ linux-2.6.17-rc6/perfmon/perfmon_sysfs.c  2006-06-08 05:36:31.000000000 -0700
>  ...
> > +struct pfm_controls pfm_controls = {
> > +     .sys_group = PFM_GROUP_PERM_ANY,
> > +     .task_group = PFM_GROUP_PERM_ANY,
> > +     .arg_size_max = PAGE_SIZE,
> > +     .smpl_buf_size_max = ~0,
> > +};
> 
> This means that by default anyone can create monitoring sessions.

Yes.

> It should start out as restrictive as possible; the admin can relax
> permissions as needed.
> 

I would expect distros to set it in a more restrictive way. That is what
I have observed with the Resources Limits such as RLIMIT_MEMLOCK, for instance.

I am not sure what the mainline policy is on this.

I am glad you looked at that permission code because I found a bug there
related to sys_group/task_group.

Thanks.

-- 

-Stephane
