Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWALMsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWALMsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWALMsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:48:30 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:15238 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964912AbWALMs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:48:29 -0500
Date: Thu, 12 Jan 2006 13:48:30 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ben Collins <ben.collins@ubuntu.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-Reply-To: <1137068880.4254.8.camel@grayson>
Message-ID: <Pine.LNX.4.61.0601121342200.11765@scrub.home>
References: <0ISL003ZI97GCY@a34-mta01.direcway.com> <200601090109.06051.zippel@linux-m68k.org>
 <1136779153.1043.26.camel@grayson> <200601091232.56348.zippel@linux-m68k.org>
 <1136814126.1043.36.camel@grayson> <Pine.LNX.4.61.0601120019430.30994@scrub.home>
 <1137031253.9643.38.camel@grayson> <Pine.LNX.4.61.0601121155450.30994@scrub.home>
 <1137068880.4254.8.camel@grayson>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 Jan 2006, Ben Collins wrote:

> > silentoldconfig gives you exactly the same information. Both conf and 
> > oldconfig will change invisible options without telling you, so it's not 
> > exact at all.
> > If you can't trust a silent oldconfig, a more verbose oldconfig can't tell 
> > you anything else, if it would it's a bug.
> 
> silentoldconfig tells you a lot less, agreed?

No.

> Hijack? It was broken, correct? It has always been broken. This problem
> has existed for as long as I've been handling kernel builds with Debian
> (which seems to be about 6-7 years now). So intended behavior aside, it
> has never worked as intended.

And it took you 6 years to report this problem?

> > > 5) My patch did not break anything, nor did it change anything that was
> > > already working.
> > 
> > It _was_ working like that, you're breaking it.
> 
> At what point did oldconfig use default values when stdin was closed?

It broke with this patch:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commit;h=4b518e42f97b96abd84f5106e43711dbff3c5707

> > So simply use silentoldconfig.
> 
> That's not the usage I want.

You only want some specific output, which has zero advantage over the 
silentoldconfig output.

bye, Roman
