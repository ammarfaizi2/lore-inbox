Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422800AbWBIFGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbWBIFGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 00:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbWBIFGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 00:06:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:54201 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422800AbWBIFGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 00:06:06 -0500
Subject: Re: sound problem on recent PowerBook5,8 MacRISC3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1139460919.30058.16.camel@mindpipe>
References: <20060208160002.GI5538@washoe.onerussian.com>
	 <1139437750.5003.19.camel@localhost.localdomain>
	 <1139460919.30058.16.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 16:04:41 +1100
Message-Id: <1139461481.5003.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 23:55 -0500, Lee Revell wrote:
> On Thu, 2006-02-09 at 09:29 +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2006-02-08 at 11:00 -0500, Yaroslav Halchenko wrote:
> > > Dear Kernel People,
> > > 
> > > Sound fails to work on the PowerBook laptop
> > > information on which could be found from
> > > http://www.onerussian.com/Linux/bugs/bug.sound/
> > > 
> > > On 2.6.16-rc1 and got
> > > dmasound_pmac: couldn't find a Codec we can handle
> > > ....
> > > snd: Unknown layout ID 0x52
> > > (and ALSA failed to find any device)
> > 
> > The sound chipset on these new machines isn't yet supported.
> > 
> 
> Please file a feature request in the ALSA bugzilla, so this won't get
> lost.  Please include pointers to any Darwin code or any other docs you
> think might help.
> 
> https://bugtrack.alsa-project.org/alsa-bug/login_select_proj_page.php?ref=bug_report_advanced_page.php

Well, I have started tracking down all chipset models and all ways they
are routed in the different mac models. It's a total mess but I'm slowly
getting there. I intend to rewrite a new driver that can handle properly
those new scenarios of multiple i2c busses and multiple codecs per bus,
among others.

Ben.

