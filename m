Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266965AbUBRAmE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUBRAmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:42:01 -0500
Received: from mailbox8.ucsd.edu ([132.239.1.60]:8466 "EHLO mailbox8.ucsd.edu")
	by vger.kernel.org with ESMTP id S266965AbUBRAk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:40:56 -0500
From: Athanasios Leontaris <aleontar@ucsd.edu>
To: Thomas Weich <weicht@in.tum.de>
Subject: Re: 2.6.2 Kernel Badness with 1.0-5336 NVIDIA driver
Date: Tue, 17 Feb 2004 16:40:38 -0800
User-Agent: KMail/1.6
Cc: s0348365@sms.ed.ac.uk, linux-kernel@vger.kernel.org
References: <200402170808.21530.aleontar@ucsd.edu> <200402170957.51875.aleontar@ucsd.edu> <200402172131.52993.weicht@in.tum.de>
In-Reply-To: <200402172131.52993.weicht@in.tum.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Message-Id: <200402171640.39177.aleontar@ucsd.edu>
X-MailScanner: PASSED (v1.2.8 32906 i1I0eg8x065275 mailbox8.ucsd.edu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed it shows up on my /var/log/messages* on two other occasions without 
hanging the system then. _But_ I had 5328 then. At least this badness shows 
up through 5328 and 5336, if that could provide a pointer to somebody (NVIDIA 
are you listening?)...

On Tuesday 17 February 2004 12:31 pm, Thomas Weich wrote:
> I had the same problems with NVidia 1.0-5336 but there was no hint
> in /var/log/* that the NVidia driver caused the freeze. It wasn't necessary
> that X  was running, loading the nvidia Module was sufficient to freeze the
> complete system after an unspecified amount of time.
>
> For me, it worked to use the 1.0-5328 version with patches from
> www.minion.de. Since then, everything is working without problems.
>
> I'm not on the list.
>
> Thomas
>
> > I checked it. "RenderAccel" is not set.
> > Maybe FW and SBA have something to do with it, but that's just a guess.
> > Thanks.
> >
> > On Tuesday 17 February 2004 09:54 am, Alistair John Strachan wrote:
> > > On Tuesday 17 February 2004 16:08, you wrote:
> > > > Hi to all,
> > > >
> > > > Pls cc me as I am not subscribing.
> > > > I know that the kernel is tainted so pls don't flame ;)
> > > > The kernel is 2.6.2 from www.kernel.org and I use AGPGART for AGP
> > > > (_not_ NvAGP). Fast Writes and SBA are enabled. FC1 is the distro.
> > > > The mobo is Abit KG7 and the video card an FX5600.
> > > >
> > > > X stopped responding out of the blue, at a KDE 3.2 desktop, and it
> > > > could not be killed either. The following messages were uncovered in
> > > > my /var/log/messages:
> > >
> > > [snip]
> > >
> > > Please first check to see if /etc/X11/XF86Config or
> > > /etc/X11/XF86Config-4 contains the string:
> > >
> > > Option "RenderAccel" "1"
> > >
> > > If it does, either remove the line or replace it with:
> > >
> > > Option "RenderAccel" "0"
> > >
> > > Render acceleration is still not working with the proprietary driver.
> > > I'm not saying it's definitely this, it just might not be related to
> > > the messages in syslog.
> > >
> > > I occasionally see these badness messages in syslog, but my machine
> > > never locks up. I was under the impression that these were only
> > > warnings.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
