Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266681AbUG0Wpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266681AbUG0Wpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266682AbUG0Wpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:45:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52919 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266681AbUG0Wpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:45:34 -0400
Date: Tue, 27 Jul 2004 18:56:32 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [I4L] Fix IRQ-sharing lockup in nj_s
Message-ID: <20040727215632.GB20341@logos.cnet>
References: <20040727082241.GA15624@gondor.apana.org.au> <20040727101927.GA11952@pingi3.kke.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727101927.GA11952@pingi3.kke.suse.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied, thanks Herbert and Karsten.

Just please stop using my old email address :) 

On Tue, Jul 27, 2004 at 12:19:27PM +0200, Karsten Keil wrote:
> Yes, correct.
> 
> On Tue, Jul 27, 2004 at 06:22:41PM +1000, Herbert Xu wrote:
> > Hi:
> > 
> > This is a backport of a fix that's already in 2.6.  The problem is that
> > nj_s is enabling interrupts before the handler is even installed.  This
> > patch delays the call until after the handler has been registered.
