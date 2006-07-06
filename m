Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWGFS4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWGFS4L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWGFS4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:56:11 -0400
Received: from mail.electro-mechanical.com ([216.184.71.30]:52113 "EHLO
	mail.electro-mechanical.com") by vger.kernel.org with ESMTP
	id S1750739AbWGFS4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:56:10 -0400
Date: Thu, 6 Jul 2006 14:56:06 -0400
From: William Thompson <wt@electro-mechanical.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA in 2.6.17 vs 2.6.15 (x86/ICH6)
Message-ID: <20060706185606.GV28967@electro-mechanical.com>
References: <20060630184156.GA8086@electro-mechanical.com> <1151701440.32444.44.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151701440.32444.44.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 05:04:00PM -0400, Lee Revell wrote:
> On Fri, 2006-06-30 at 14:41 -0400, William Thompson wrote:
> > *** I'm not on the list, please always keep me in CC ***
> > 
> > The speed of SATA in 2.6.17 is significantly lower in my test than 2.6.15.
> > 
> > In .15, I would see over 10mb/sec avg writing over 16,000 files (~2.4gb) to a
> > fat32 partition.
> > 
> > In .17, I see it start at 2-3mb/sec and work it's way down to 500kb/sec
> > towards the end.  Even the system is not as responsive (The system's / is a
> > tmpfs which all programs, including /usr, are stored), not even when using
> > ssh.
> > 
> > I used the same .config in .17 as I did with .15 (make oldconfig)
> 
> What does the oprofile output look like for both cases?

Lee, turns out this problem was due to a new option introduced in 2.6.16
that I turned off (Thinking it would save on space).  The option was
CONFIG_SLAB.  Apparently, SLOB is not worth using in my case.  It's a bit
too fat on memory usage.
