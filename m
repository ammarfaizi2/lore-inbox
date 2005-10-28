Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbVJ1RFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVJ1RFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 13:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVJ1RFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 13:05:54 -0400
Received: from waste.org ([216.27.176.166]:17868 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030257AbVJ1RFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 13:05:53 -0400
Date: Fri, 28 Oct 2005 10:00:31 -0700
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [ketchup] patch to alt urls for local trees
Message-ID: <20051028170030.GA4367@waste.org>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain> <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain> <20051018063031.GR26160@waste.org> <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain> <20051018072927.GU26160@waste.org> <1130504043.9574.56.camel@localhost.localdomain> <1130506546.9574.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130506546.9574.62.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 09:35:46AM -0400, Steven Rostedt wrote:
> Hi Matt,
> 
> Here's another patch.  This one allows for local alternative url paths.
> As you know, I use ketchup for Thomas Gleixner's ktimers.  He also
> stores his archives differently than everyone else.  So I have as
> my .ketchuprc the following.
> 
> local_trees = {
> 	'2.6-kt': (latest_dir,
> 		"http://www.tglx.de/projects/ktimers/patch-%(full)s.patch",
> 		r'patch-(2.6.*?)',
> 		0, "Thomas Gleixner's ktimers."),
> 	'2.6-kthrt': (latest_dir,
> 		"http://www.tglx.de/projects/ktimers/patch-%(full)s.patch",
> 		r'patch-(2.6.*?)',
> 		0, "Thomas Gleixner's ktimers and HRT patches.")
> }
> 
> local_alturls = {
> 	'/ktimers/' : "/ktimers/archive/"
> }

Hmm. I think I'd prefer to generalize this by adding another field to
the tree array. Care to take a stab at it?

-- 
Mathematics is the supreme nostalgia of our time.
