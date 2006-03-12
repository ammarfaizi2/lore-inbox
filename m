Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWCLOar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWCLOar (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 09:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWCLOar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 09:30:47 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:46228 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750810AbWCLOaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 09:30:46 -0500
Date: Sun, 12 Mar 2006 15:30:43 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 5/8] hrtimer remove state field
In-Reply-To: <1142172917.19916.421.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603121523320.16802@scrub.home>
References: <20060312080316.826824000@localhost.localdomain> 
 <20060312080332.274315000@localhost.localdomain>  <Pine.LNX.4.64.0603121302590.16802@scrub.home>
  <1142169010.19916.397.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0603121422180.16802@scrub.home>  <1142170505.19916.402.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121444530.16802@scrub.home> <1142172917.19916.421.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 12 Mar 2006, Thomas Gleixner wrote:

> > > > > base->unlock()
> > > > > 			signal of previous expiry is delivered on CPU1
> > > > > 			timer is reqeued.
> > > 
> > > 		------->  sig_ignore is set
> > 
> > ??? I can't find any symbol 'sig_ignore'.
> 
> Oh well. The application sets SIG_IGN for the signal in question, so
> send_sigqueue() returns 1 because sig_ignored() returns 1.

In this case no signal is queued and the timer won't be restarted via 
signal delivery.

bye, Roman
