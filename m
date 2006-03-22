Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751981AbWCVCDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbWCVCDB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 21:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbWCVCDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 21:03:00 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:5300 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751981AbWCVCDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 21:03:00 -0500
Date: Wed, 22 Mar 2006 03:02:59 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       "Eric W.Biederman" <ebiederm@xmission.com>,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH 1/7] Add process virtualisation umbrella structure (vx_info)
Message-ID: <20060322020258.GA28925@MAIL.13thfloor.at>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
	"Eric W.Biederman" <ebiederm@xmission.com>,
	OpenVZ developers list <dev@openvz.org>,
	"Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
References: <20060321061333.27638.63963.stgit@localhost.localdomain> <20060321061333.27638.9112.stgit@localhost.localdomain> <1142967185.10906.188.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142967185.10906.188.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 10:53:05AM -0800, Dave Hansen wrote:
> On Tue, 2006-03-21 at 18:13 +1200, Sam Vilain wrote:
> > +static inline void release_vx_info(struct vx_info *vxi,
> > +       struct task_struct *task)
> > +{
> > +       might_sleep();
> > +
> > +       if (atomic_dec_and_test(&vxi->vx_tasks))
> > +               unhash_vx_info(vxi);
> > +} 
> 
> Are these better handled by krefs and their destructors?

well, those were there long before krefs got
into the kernel, IIRC :)

best,
Herbert

> -- Dave
