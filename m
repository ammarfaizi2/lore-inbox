Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWBNLiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWBNLiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 06:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWBNLiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 06:38:16 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:14571 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161012AbWBNLiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 06:38:15 -0500
Date: Tue, 14 Feb 2006 12:38:10 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: [PATCH 10/12] hrtimer: remove useless const
In-Reply-To: <20060214111648.GA26311@elte.hu>
Message-ID: <Pine.LNX.4.61.0602141234200.30994@scrub.home>
References: <Pine.LNX.4.61.0602141111380.3741@scrub.home> <20060214111648.GA26311@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Feb 2006, Ingo Molnar wrote:

> > A const for arguments which are passed by value is completely ignored 
> > by gcc. It has only an effect on local variables and even here a 
> > recent gcc doesn't need it either to produce better code. I left a few 
> > const which help gcc-3.x to produce slightly smaller code.
> 
> still nack... Using const is _not a bug_, and in fact there are some 
> good reasons to make use of it - so it should be left up to the authors 
> of the code how much they make use of const. This patch also creates 
> quite some churn in the -hrt queue, for no good reason.

The current const usage is way too much, for no good reason either. I 
don't mind adding a few const back, but declaring every simple argument 
const is just insane.

bye, Roman
