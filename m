Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWDFTBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWDFTBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 15:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWDFTBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 15:01:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:8594 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932125AbWDFTBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 15:01:04 -0400
Date: Thu, 6 Apr 2006 21:00:54 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: johnstul@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] generic clocksource updates
In-Reply-To: <1144317972.5344.681.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604062048130.17704@scrub.home>
References: <Pine.LNX.4.64.0604032155070.4707@scrub.home>
 <1144317972.5344.681.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Apr 2006, Thomas Gleixner wrote:

> On Mon, 2006-04-03 at 21:55 +0200, Roman Zippel wrote:
> >  struct clocksource {
> >  	char *name;
> > @@ -58,11 +57,11 @@ struct clocksource {
> >  	u32 mult;
> >  	u32 shift;
> >  	int (*update_callback)(void);
> > -	int is_continuous;
> 
> This field was introduced to have a clear property description. The
> rating field might be used for this, but from a given rating on a
> particular CPU architecture it might be hard to deduce whether this
> clock source is good enough so we can switch to high resolution timer
> mode.

Currently this field isn't needed and as soon we have a need for it, we 
can add proper capability information.

bye, Roman
