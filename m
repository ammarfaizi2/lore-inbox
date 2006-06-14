Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWFNBUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWFNBUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWFNBUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:20:40 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:30935 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964866AbWFNBUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:20:39 -0400
Subject: Re: [PATCH 03/11] Task watchers:  Refactor process events
From: Matt Helsley <matthltc@us.ibm.com>
To: Chase Venters <chase.venters@clientec.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
In-Reply-To: <200606131943.34800.chase.venters@clientec.com>
References: <20060613235122.130021000@localhost.localdomain>
	 <1150242879.21787.143.camel@stark>
	 <200606131943.34800.chase.venters@clientec.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 18:11:22 -0700
Message-Id: <1150247482.21787.206.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 19:43 -0500, Chase Venters wrote:
> On Tuesday 13 June 2006 18:54, Matt Helsley wrote:
> 
> > +	WARN_ON((which_id != PROC_EVENT_UID) && (which_id != PROC_EVENT_GID));
> >  }
> 
> How about WARN_ON(!(which_id & (PROC_EVENT_UID | PROC_EVENT_GID))) to save a 
> cmp?
> 
> Thanks,
> Chase

I think the compiler is capable of making such optimizations. I also
think what I have now is clearer to anyone skimming the code.

Cheers,
	-Matt Helsley

