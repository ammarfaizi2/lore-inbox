Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265987AbUFIV2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUFIV2G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265988AbUFIV2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:28:06 -0400
Received: from fmr06.intel.com ([134.134.136.7]:58795 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265987AbUFIV17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:27:59 -0400
From: Mark Gross <mgross@linux.jf.intel.com>
Organization: Intel
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark Gross <mgross@linux.jf.intel.com>
Subject: Re: swsusp "not enough swap space" 2.6.5-mm6.
Date: Wed, 9 Jun 2004 14:28:26 -0700
User-Agent: KMail/1.5.4
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <200406080829.35120.mgross@linux.intel.com> <200406090927.51206.mgross@linux.intel.com> <1086810480.1982.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1086810480.1982.1.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406091428.26446.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 June 2004 12:48, Felipe Alfaro Solana wrote:
> On Wed, 2004-06-09 at 09:27 -0700, Mark Gross wrote:
> > On Wednesday 09 June 2004 08:32, Mark Gross wrote:
> > > On Tuesday 08 June 2004 16:04, Pavel Machek wrote:
> > > > Hi!
> > > >
> > > > > I'm sorry for not having more information, but the failing computer
> > > > > is my home laptop (I'll get more details after work or I'll bring
> > > > > it in tomorrow for more details).
> > > > >
> > > > > Anyway, this thing does software suspend using the 2.6.2-mm1
> > > > > kernel, and last night I was updating it to 2.6.5-mm6, and I
> > > > > started getting these not enough disk space errors.
> > > > >
> > > > > I found your bug fix patch,
> > > > > http://marc.theaimsgroup.com/?l=linux-kernel&m=107806008626357&w=2
> > > > >  and checked that it is included in the 2.6.5-mm6 kernel I'm using.
> > > > >
> > > > > Without more information does this problem ring any bells?
> > > > >
> > > > > Can you recommend a "good" kernel version that does reliable
> > > > > swsusp?
> > > >
> > > > Get 2.6.6, and set swappiness to 100.
> > > >
> > > > 								Pavel
> > >
> > > 2.6.6 still fails, just like the failure reported by the thread
> > > independent of swappiness:
> > >
> > > http://marc.theaimsgroup.com/?t=107806010900002&r=1&w=2
> > >
> > > However; as hinted in the thread turning off premption does seem to fix
> > > the problem.
> >
> > Spoke too soon.  My build tree that had the success was 2.6.6-mm6, so I
> > re-built a clean 2.6.6 from tarball using the .config from the successful
> > run, CONFIG_PREEMPT=n.  It fails.  2.6.6-mm5 works, but only if
> > CONFIG_PREEMPT=n.
> >
> > I have to get to my day job now, but whats up with the flakieness of the
> > swsusp?  Shouldn't it be mostly working by now?
>
> It's working flawlessly for me with 2.6.7-rc3-mm1. I also applied the
> following patches (who knows)...

They seem to work for me too, but I can't build with CONFIG_PERFCTR :)

thanks,

--mgross

