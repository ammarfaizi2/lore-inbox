Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUFIQ1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUFIQ1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUFIQ1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:27:31 -0400
Received: from fmr05.intel.com ([134.134.136.6]:20692 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265812AbUFIQ13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 12:27:29 -0400
From: Mark Gross <mgross@linux.jf.intel.com>
Organization: Intel
To: Pavel Machek <pavel@ucw.cz>, Mark Gross <mgross@linux.jf.intel.com>
Subject: Re: swsusp "not enough swap space" 2.6.5-mm6.
Date: Wed, 9 Jun 2004 09:27:51 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200406080829.35120.mgross@linux.intel.com> <20040608230450.GA13916@elf.ucw.cz> <200406090832.04064.mgross@linux.intel.com>
In-Reply-To: <200406090832.04064.mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406090927.51206.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 June 2004 08:32, Mark Gross wrote:
> On Tuesday 08 June 2004 16:04, Pavel Machek wrote:
> > Hi!
> >
> > > I'm sorry for not having more information, but the failing computer is
> > > my home laptop (I'll get more details after work or I'll bring it in
> > > tomorrow for more details).
> > >
> > > Anyway, this thing does software suspend using the 2.6.2-mm1 kernel,
> > > and last night I was updating it to 2.6.5-mm6, and I started getting
> > > these not enough disk space errors.
> > >
> > > I found your bug fix patch,
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=107806008626357&w=2
> > >  and checked that it is included in the 2.6.5-mm6 kernel I'm using.
> > >
> > > Without more information does this problem ring any bells?
> > >
> > > Can you recommend a "good" kernel version that does reliable swsusp?
> >
> > Get 2.6.6, and set swappiness to 100.
> >
> > 								Pavel
>
> 2.6.6 still fails, just like the failure reported by the thread independent
> of swappiness:
>
> http://marc.theaimsgroup.com/?t=107806010900002&r=1&w=2
>
> However; as hinted in the thread turning off premption does seem to fix the
> problem.
>

Spoke too soon.  My build tree that had the success was 2.6.6-mm6, so I 
re-built a clean 2.6.6 from tarball using the .config from the successful 
run, CONFIG_PREEMPT=n.  It fails.  2.6.6-mm5 works, but only if 
CONFIG_PREEMPT=n.

I have to get to my day job now, but whats up with the flakieness of the 
swsusp?  Shouldn't it be mostly working by now?


--mgross

