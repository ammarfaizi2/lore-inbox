Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVGKOKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVGKOKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVGKOHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:07:32 -0400
Received: from thunk.org ([69.25.196.29]:53398 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261755AbVGKOGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:06:31 -0400
Date: Mon, 11 Jul 2005 10:05:10 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, azarah@nosferatu.za.org, cw@f00f.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050711140510.GB14529@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
	arjan@infradead.org, azarah@nosferatu.za.org, cw@f00f.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@osdl.org, christoph@lameter.org
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org> <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe> <1120933916.3176.57.camel@laptopd505.fenrus.org> <1120934163.6488.72.camel@mindpipe> <20050709121212.7539a048.akpm@osdl.org> <1120936561.6488.84.camel@mindpipe> <1121088186.7407.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121088186.7407.61.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 02:23:08PM +0100, Alan Cox wrote:
> > > Because some machines exhibit appreciable latency in entering low power
> > > state via ACPI, and 1000Hz reduces their battery life.  By about half,
> > > iirc.
> > > 
> > Then the owners of such machines can use HZ=250 and leave the default
> > alone.  Why should everyone have to bear the cost?
> 
> They need 100 really it seems, 250-500 have no real effect and on the
> Dell I tried 250 didn't stop the wild clock slew from the APM bios
> either. I played with this a fair bit on a couple of laptops. I've not
> seen anything > 20% saving however so I've no idea who/why someone saw
> 50%

The real answer here is for the tickless patches to cleaned up to the
point where they can be merged, and then we won't waste battery power
entering the timer interrupt in the first place.  :-)

						- Ted
