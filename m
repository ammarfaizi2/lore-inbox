Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbSLMMMJ>; Fri, 13 Dec 2002 07:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSLMMMI>; Fri, 13 Dec 2002 07:12:08 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:41659 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264638AbSLMMMI>;
	Fri, 13 Dec 2002 07:12:08 -0500
Date: Fri, 13 Dec 2002 18:02:41 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: John Levon <levon@movementarian.org>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Notifier for significant events on i386
Message-ID: <20021213180241.A23046@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net> <20021211165153.A17546@in.ibm.com> <20021211111639.GJ9882@holomorphy.com> <20021211171337.A17600@in.ibm.com> <20021211202727.GF20735@compsoc.man.ac.uk> <1039641336.18587.30.camel@irongate.swansea.linux.org.uk> <1039652384.1649.17.camel@dell_ss3.pdx.osdl.net> <20021212130406.A20253@in.ibm.com> <1039715615.1649.80.camel@dell_ss3.pdx.osdl.net> <20021212175804.GA15860@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021212175804.GA15860@compsoc.man.ac.uk>; from levon@movementarian.org on Thu, Dec 12, 2002 at 05:58:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 05:58:04PM +0000, John Levon wrote:
> On Thu, Dec 12, 2002 at 09:53:35AM -0800, Stephen Hemminger wrote:
> 
> > The use of notifier today is limited to things that can't sleep. As far
> 
> kernel/profile.c
> 
> You'd have to move that to a different API if you want to force notifier
> callbacks non-sleepable
> 
Yes, indeed most of the existing notifiers potentially sleep. That is why
I think we should, may be, leave the existing notifiers alone. Add a
notifier_call_chain_safe() and use that to run trap1/trap3/NMI etc 
notifiers.

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
