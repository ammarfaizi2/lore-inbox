Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVKKRML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVKKRML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVKKRML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:12:11 -0500
Received: from i121.durables.org ([64.81.244.121]:52119 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750930AbVKKRMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:12:10 -0500
Date: Fri, 11 Nov 2005 09:11:40 -0800
From: Matt Mackall <mpm@selenic.com>
To: Nick Warne <nick@linicks.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] misc: Configurable number of supported IDE interfaces
Message-ID: <20051111171140.GV11462@waste.org>
References: <200511111533.13474.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511111533.13474.nick@linicks.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 03:33:13PM +0000, Nick Warne wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > You are duplicating functionality of CONFIG_IDE_MAX_HWIFS,
> > please find a way to use it for EMBEDDED.
> > 
> > Also please cc: linux-ide on IDE related patches.
> > 
> > On 11/11/05, Matt Mackall <mpm@selenic.com> wrote:
> >> Configurable number of supported IDE interfaces
> >>
> >> This overrides the default limit (which may be set per arch with
> >> CONFIG_IDE_MAX_HWIFS). This is the result of setting interfaces to 1:
> 
> This is very similar to my unaccepted patch a few months ago:
> 
> http://lkml.org/lkml/2005/6/25/69

And it's practically identical to the one that's been in my -tiny tree
for two years.

I agree with Alan's complaint that this should in fact be done with
dynamic allocation. However, when I last set out to do that, it
appeared to be an _extremely_ invasive change so I quickly abandoned
it.

Meanwhile, this is currently the largest static allocation in a
typical kernel. Something has to be done.

-- 
Mathematics is the supreme nostalgia of our time.
