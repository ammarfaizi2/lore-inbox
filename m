Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVFTKX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVFTKX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFTKX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:23:27 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:3491 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261329AbVFTKWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:22:55 -0400
Date: Mon, 20 Jun 2005 12:22:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
In-Reply-To: <42B685E8.9359.14B98F19@rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.61.0506201159060.3728@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
 <42B685E8.9359.14B98F19@rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Jun 2005, Ulrich Windl wrote:

> Basically, either the new clock system has to be optional (a maintenance nightmare 
> most likely), or you'll have to require a specific amount of performance for the 
> latest software. If you cannot fulfill the requirements, you'll have to stick with 
> an older release of the software.
> 
> Maybe let's try to make it as good (correct and efficient (and understandable) as 
> good as we can.

If nobody can explain to me the perfomance impact of patch, maybe the 
patch isn't so understandable in first place?
I could also have asked how that code scales up, e.g. how much more work 
has to be done for a thousand Linux images. (AFAICR this question also 
came up in the context of tickless systems).

This patch is really damned hard to read as it changes too many things at 
once. Maybe it does some necessary cleanups, but they are hard see, as 
they pretty much get lost in all the functional changes.
I'm pretty close to suggest to reject this patch until it clearly 
separates new functionality from cleanups. If the current system is broken 
fix it first, if the current system is a mess clean it up first, but 
don't mix these two steps, unless you want to introduce more broken mess.

bye, Roman
