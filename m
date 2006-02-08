Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbWBHVjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWBHVjk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWBHVjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:39:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965158AbWBHVjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:39:39 -0500
Date: Wed, 8 Feb 2006 13:39:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: pj@sgi.com, clameter@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
Message-Id: <20060208133909.183f19ea.akpm@osdl.org>
In-Reply-To: <200602082221.35671.ak@suse.de>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
	<200602082201.12371.ak@suse.de>
	<20060208130351.fc1c759c.pj@sgi.com>
	<200602082221.35671.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Wednesday 08 February 2006 22:03, Paul Jackson wrote:
> > > I don't think you really want to open a  full scale "is the oom killer needed"
> > > thread. Check the archives - there have been some going on for months.
> > > 
> > > But I think we can agree that together with mbind the oom killer is pretty
> > > useless, can't we?
> > 
> > Excellent points.
> > 
> > I approve this patch.
> 
> I think it should be put into 2.6.16. Andrew?

Does every single caller of __alloc_pages(__GFP_FS) correctly handle a NULL
return?  I doubt it, in which case this patch will cause oopses and hangs.

