Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVGAHyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVGAHyv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVGAHyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:54:50 -0400
Received: from styx.suse.cz ([82.119.242.94]:9134 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262532AbVGAHyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:54:37 -0400
Date: Fri, 1 Jul 2005 09:54:34 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline sleep/delay functions
Message-ID: <20050701075434.GB2041@ucw.cz>
References: <200506300852.25943.vda@ilport.com.ua> <20050630021111.35aaf45f.akpm@osdl.org> <1120123189.3181.28.camel@laptopd505.fenrus.org> <200506301321.20692.vda@ilport.com.ua> <1120128441.3181.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120128441.3181.37.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 12:47:21PM +0200, Arjan van de Ven wrote:
> On Thu, 2005-06-30 at 13:21 +0300, Denis Vlasenko wrote:
> > On Thursday 30 June 2005 12:19, Arjan van de Ven wrote:
> > > 
> > > > > There are a number of compile-time checks that your patch has removed
> > > > > which catch such things, and as such your patch is not acceptable.
> > > > > Some architectures have a lower threshold of acceptability for the
> > > > > maximum udelay value, so it's absolutely necessary to keep this.
> > > > 
> > > > It removes that check from x86 - other architectures retain it.
> > > > 
> > > > 
> > For users, _any_ value, however large, will work for
> > any delay function.
> 
> that's not desired though. Desired is to limit udelay() to say 2000 or
> so. And force anything above that to go via mdelay() (just to make it
> stand out as broken code ;)
> 
> Over time we also want to phase out mdelay of course...
 
The joystick drivers will (sadly) need mdelay forever,
due to hardware crappines.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
