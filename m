Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVJ1D4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVJ1D4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 23:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbVJ1D4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 23:56:13 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:32705 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965082AbVJ1D4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 23:56:11 -0400
Subject: Re: The "best" value of HZ
From: Lee Revell <rlrevell@joe-job.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Claudio Scordino <cloud.of.andor@gmail.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
In-Reply-To: <200510280331.21112.s0348365@sms.ed.ac.uk>
References: <200510280118.42731.cloud.of.andor@gmail.com>
	 <200510280331.21112.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 23:45:35 -0400
Message-Id: <1130471136.4363.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 03:31 +0100, Alistair John Strachan wrote:
> On Friday 28 October 2005 00:18, Claudio Scordino wrote:
> > Hi,
> >
> >     during the last years there has been a lot of discussion about the
> > "best" value of HZ... On i386 was 100, then became 1000, and finally was
> > set to 250. I'm thinking to do an evaluation of this parameter using
> > different architectures.
> >
> > Has anybody thought to give the possibility to modify the value of HZ at
> > boot time instead of at compile time ? This would allow to easily test
> > different values on different machines and create a table containing the
> > "best" value for each architecture...  At this moment, instead, we have to
> > recompile the kernel for each different value :(
> >
> > Do you think there would be much work to do that ?
> > Do you think it would be a desired feature the knowledge of the best value
> > for each architecture with more precision ?
> 
> Google for "dynticks". There's obviously an overhead associated with HZ not 
> being a constant (the compiler cannot optimise many expressions), but the 
> feature is being worked on nonetheless.
> 

Well Linus had the best idea in that thread (as usual) which was to
implement "dynamic ticks" by leaving HZ a constant, setting it to a high
value, and skipping ticks when idle.  Has there been any work in that
direction?

Lee

