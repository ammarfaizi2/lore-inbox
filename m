Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbULBRZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbULBRZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbULBRZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:25:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55757 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261693AbULBRZB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:25:01 -0500
Date: Thu, 2 Dec 2004 09:18:29 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041202111829.GA3180@dmt.cyclades>
References: <20041201104820.1.patchmail@tglx> <20041201211638.GB4530@dualathlon.random> <1101938767.13353.62.camel@tglx.tec.linutronix.de> <20041202033619.GA32635@dualathlon.random> <1101985759.13353.102.camel@tglx.tec.linutronix.de> <1101995280.13353.124.camel@tglx.tec.linutronix.de> <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202085518.58e0e8eb.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 08:55:18AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > I believe the thing you're hiding with the callback, is some screwup in
> >  the VM. It shouldn't fire oom 300 times in a row.
> 
> Well no ;) 

I bet zone->all_unreclaimable is one of the main issues here as Andrea notes.

> Thomas, could you please put together a description of how to reproduce
> this behaviour?

A simple "fillmem" works for me - the OOM killer kills the hog and the bash 
which its being ran from. Have you tried that? 

If you fire up a few fillmem's at the same time I bet you'll see the problem in a 
greater degree.
