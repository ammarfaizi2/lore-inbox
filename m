Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130262AbRCBCnc>; Thu, 1 Mar 2001 21:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130267AbRCBCnX>; Thu, 1 Mar 2001 21:43:23 -0500
Received: from [209.102.105.34] ([209.102.105.34]:46345 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S130262AbRCBCnQ>;
	Thu, 1 Mar 2001 21:43:16 -0500
Date: Thu, 1 Mar 2001 18:43:03 -0800
From: Tim Wright <timw@splhi.com>
To: "Matilainen Panu (NRC/Helsinki)" <panu.matilainen@nokia.com>
Cc: ext Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x very unstable on 8-way IBM 8500R
Message-ID: <20010301184303.A5065@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: "Matilainen Panu (NRC/Helsinki)" <panu.matilainen@nokia.com>,
	ext Andrew Morton <andrewm@uow.edu.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A9E3F00.E5667AAC@uow.edu.au> <Pine.LNX.4.30.0103011523200.23756-100000@godzilla.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0103011523200.23756-100000@godzilla.research.nokia.com>; from panu.matilainen@nokia.com on Thu, Mar 01, 2001 at 03:30:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI,
I am chasing this problem. There appears to be an unpleasant interaction between
the Advanced Systems Management card and the NMI watchdog code. Ripping the card
out of the machine also eradicates the problem, but is less desirable. 
I'll let people know when there's a better solution.

Tim

On Thu, Mar 01, 2001 at 03:30:56PM +0200, Matilainen Panu (NRC/Helsinki) wrote:
> On Thu, 1 Mar 2001, ext Andrew Morton wrote:
> > "Matilainen Panu (NRC/Helsinki)" wrote:
> > > On Thu, 1 Mar 2001, ext Andrew Morton wrote:
> > > >
> > > > Is it stable with `nmi_watchdog=0'?
> > >
> > > If the default value for nmi_watchdog is 0 then no - I added the
> > > nmi_watchdog=1 just to see if that makes any difference. If it's on by
> > > default then I'll need to test it that way.
> >
> > Default for nmi_watchdog is `enabled'.
> >
> > Several people have reported that turning it off with
> > the `nmi_watchdog=0' LILO option makes systems stable.
> > Nobody knows why.
> >
> > (If nmi_watchdog _does_ make the achine stable, please
> >  tell linux-kernel.).
> 
> It's too early to say for sure but that seems to have fixed it. Uptime now
> nearly an hour under loads of 20-30 which is way more than it has been
> able to stay up before. I'll let you know whether its still up tomorrow.
> 
> Million thanks for the tip!
> 
> 	- Panu -
> 

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
