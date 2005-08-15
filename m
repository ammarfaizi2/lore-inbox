Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVHOMxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVHOMxh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 08:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVHOMxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 08:53:36 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:51127 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750741AbVHOMxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 08:53:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Mon, 15 Aug 2005 22:52:47 +1000
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@suse.cz>, Jim MacBaine <jmacbaine@gmail.com>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
References: <200508031559.24704.kernel@kolivas.org> <20050814194756.GC1686@openzaurus.ucw.cz> <Pine.LNX.4.61.0508141942480.6740@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0508141942480.6740@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508152252.47825.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2005 11:43, Zwane Mwaikambo wrote:
> On Sun, 14 Aug 2005, Pavel Machek wrote:
> > > Ok perhaps on the resume side instead. When trying to resume can you
> > > try booting with 'dyntick=disable'. Note this isn't meant to be a long
> > > term fix but once we figure out where the problem is we should be able
> > > to code around it.
> >
> > Can you reproduce it using plain swsusp?
> >
> > We probably need more carefull suspend/resume support on timer with
> > dyntick enabled.
> >
> > With vanilla, timer just ticks on constant rate; no state to save.
> > With dyntick, however...
>
> Why not just set it to a fixed frequency, suspend and then on boot resume
> to a fixed frequency and let the timer tick code eventually switch back.

It's probably worth holding off further discussion on this point till the SMP 
scalable version is working well enough and see if/how the problem manifests 
there.

Cheers,
Con
