Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbUJaCyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbUJaCyW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 22:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbUJaCyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 22:54:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:27031 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261482AbUJaCyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 22:54:19 -0400
Date: Sun, 31 Oct 2004 03:54:18 +0100
From: Andi Kleen <ak@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add panic blinking to 2.6
Message-ID: <20041031025418.GH19396@wotan.suse.de>
References: <20041031013649.GF19396@wotan.suse.de> <20041031022537.GB18294@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031022537.GB18294@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 07:25:37PM -0700, Chris Wedgwood wrote:
> > +static int blink_frequency = 500;
> > +module_param_named(panicblink, blink_frequency, int, 0600);
> 
> does it reall need to be a module? 

It isn't a module.
> 
> > +/* Returns how long it waited in ms */
> > +long (*panic_blink)(long time) = no_blink;
> > +EXPORT_SYMBOL(panic_blink);
> 
> i dont know we can't have this unconditionally with the 500ms period
> (always present and on)
> 
> would that really harm anything?

Yes, one broken KVM seems to block switching with it in some cases

-Andi
