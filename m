Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbTIHNlk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbTIHNlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:41:35 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:45186 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262399AbTIHNkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:40:05 -0400
Subject: Re: Scaling noise
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Larry McVoy <lm@work.bitmover.com>, CaT <cat@zip.com.au>,
       Larry McVoy <lm@bitmover.com>, Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030906150817.GB3944@openzaurus.ucw.cz>
References: <20030903040327.GA10257@work.bitmover.com>
	 <20030903041850.GA2978@krispykreme>
	 <20030903042953.GC10257@work.bitmover.com>
	 <20030903043355.GC2019@zip.com.au>
	 <20030903050859.GD10257@work.bitmover.com>
	 <20030906150817.GB3944@openzaurus.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063028321.21050.28.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 14:38:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-06 at 16:08, Pavel Machek wrote:
> Hi!
> 
> > Maybe this is a better way to get my point across.  Think about more CPUs
> > on the same memory subsystem.  I've been trying to make this scaling point
> 
> The point of hyperthreading is that more virtual CPUs on same memory
> subsystem can actually help stuff.

Its a way of exposing asynchronicity keeping the old instruction set.
Its trying to make better use of the bandwidth available by having
something else to schedule into stalls. Thats why HT is really good for
code which is full of polling I/O, badly coded memory accesses but is
worthless on perfectly tuned hand coded stuff which doesnt stall.

Its great feature is that HT gets *more* not less useful as the CPU gets
faster..

