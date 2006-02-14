Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030575AbWBNLeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbWBNLeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 06:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbWBNLeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 06:34:12 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:13547 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030575AbWBNLeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 06:34:11 -0500
Date: Tue, 14 Feb 2006 12:34:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: [PATCH 00/12] hrtimer patches
In-Reply-To: <20060214110947.GA25341@elte.hu>
Message-ID: <Pine.LNX.4.61.0602141228120.30994@scrub.home>
References: <Pine.LNX.4.61.0602141057320.30994@scrub.home> <20060214110947.GA25341@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Feb 2006, Ingo Molnar wrote:

> > Here is new version of the hrtimer patches sorted by priority. I 
> > dropped the remaining time patch, the const patch doesn't produce a 
> > larger kernel with gcc3 and I also added the acks so far. I consider 
> > the first four patches the most important and the remaining patches 
> > simple enough, that I think they're still 2.6.16 material.
> 
> i only consider the first two patches to be 2.6.16 material. The other 
> patches avoid a ->get_time() call per timer interrupt - that's noise at 
> most ...

It's two get_time() calls and I don't consider it noise, they are wasting 
time with unnecessary hardware accesses.

bye, Roman
