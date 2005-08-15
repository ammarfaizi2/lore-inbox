Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbVHOBh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbVHOBh6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 21:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbVHOBh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 21:37:58 -0400
Received: from fsmlabs.com ([168.103.115.128]:6309 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S932624AbVHOBh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 21:37:57 -0400
Date: Sun, 14 Aug 2005 19:43:46 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
cc: Con Kolivas <kernel@kolivas.org>, Jim MacBaine <jmacbaine@gmail.com>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
In-Reply-To: <20050814194756.GC1686@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.61.0508141942480.6740@montezuma.fsmlabs.com>
References: <200508031559.24704.kernel@kolivas.org> <200508040716.24346.kernel@kolivas.org>
 <3afbacad050803152226016790@mail.gmail.com> <200508040852.10224.kernel@kolivas.org>
 <20050814194756.GC1686@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005, Pavel Machek wrote:

> > Ok perhaps on the resume side instead. When trying to resume can you try 
> > booting with 'dyntick=disable'. Note this isn't meant to be a long term fix 
> > but once we figure out where the problem is we should be able to code around 
> > it.
> 
> Can you reproduce it using plain swsusp?
> 
> We probably need more carefull suspend/resume support on timer with dyntick
> enabled.
> 
> With vanilla, timer just ticks on constant rate; no state to save.
> With dyntick, however...

Why not just set it to a fixed frequency, suspend and then on boot resume 
to a fixed frequency and let the timer tick code eventually switch back.
