Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWFNIKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWFNIKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 04:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWFNIKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 04:10:01 -0400
Received: from relay03.pair.com ([209.68.5.17]:24080 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751175AbWFNIKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 04:10:00 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 03/11] Task watchers:  Refactor process events
Date: Wed, 14 Jun 2006 03:09:34 -0500
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
References: <20060613235122.130021000@localhost.localdomain> <200606131943.34800.chase.venters@clientec.com> <1150247482.21787.206.camel@stark>
In-Reply-To: <1150247482.21787.206.camel@stark>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606140309.57413.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 20:11, Matt Helsley wrote:
> On Tue, 2006-06-13 at 19:43 -0500, Chase Venters wrote:
> > On Tuesday 13 June 2006 18:54, Matt Helsley wrote:
> > > +	WARN_ON((which_id != PROC_EVENT_UID) && (which_id !=
> > > PROC_EVENT_GID)); }
> >
> > How about WARN_ON(!(which_id & (PROC_EVENT_UID | PROC_EVENT_GID))) to
> > save a cmp?
> >
> > Thanks,
> > Chase
>
> I think the compiler is capable of making such optimizations. I also
> think what I have now is clearer to anyone skimming the code.

Can the compiler test that (which_id != PROC_EVENT_UID) && (which_id != 
PROC_EVENT_GID) merely by masking? Since they're bits, one mask testing both 
could technically match both (true result), which would not happen in the != 
case (false result). It is a small point though.

> Cheers,
> 	-Matt Helsley

Thanks,
Chase
