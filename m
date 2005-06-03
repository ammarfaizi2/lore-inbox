Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVFCSOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVFCSOa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVFCSO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:14:28 -0400
Received: from nevyn.them.org ([66.93.172.17]:22716 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261477AbVFCSLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:11:10 -0400
Date: Fri, 3 Jun 2005 14:11:06 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: John Blackwood <john.blackwood@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace(2) single-stepping into signal handlers
Message-ID: <20050603181106.GB29940@nevyn.them.org>
Mail-Followup-To: John Blackwood <john.blackwood@ccur.com>,
	linux-kernel@vger.kernel.org
References: <42A09C6C.8030104@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A09C6C.8030104@ccur.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 02:07:40PM -0400, John Blackwood wrote:
> > Subject: Re: [PATCH] ptrace(2) single-stepping into signal handlers
> > From: Daniel Jacobowitz <dan@debian.org>
> > Date: Fri, 3 Jun 2005 13:34:33 -0400
> > To: John Blackwood <john.blackwood@ccur.com>
> > CC: linux-kernel@vger.kernel.org, roland@redhat.com, ak@suse.de, 
> akpm@osdl.org, bugsy@ccur.com
> >
> > On Fri, Jun 03, 2005 at 01:21:20PM -0400, John Blackwood wrote:
> 
> > >> The reason for this behavior is due to the fact that:
> > >>
> > >> - We saved off the eflags (with the TF bit set) in setup_sigcontext()
> > >>   before we single stepped into the user's signal handler.
> >
> >
> > You didn't say what kernel you were using.  I believe this was fixed
> > some time ago.
> 
> Hi Dan,
> 
> I observed this behavior in a 2.6.11.10 kernel.  The code in 2.6.11.11
> looks the same in this area... this is the i386 code that I am speaking of.
> 
> I guess that 'some time ago' is more recent than that?
> 
> 
> If so, then please excuse me... and it's great that this is fixed.

I'm not sure of the timeline, but could you check that in a current
2.6.12 GIT snapshot?

-- 
Daniel Jacobowitz
CodeSourcery, LLC
