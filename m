Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVGKKDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVGKKDv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 06:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVGKKDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 06:03:51 -0400
Received: from [203.171.93.254] ([203.171.93.254]:56989 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261531AbVGKKDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 06:03:50 -0400
Subject: Re: [PATCH] [38/48] Suspend2 2.1.9.8 for 2.6.12: 614-plugins.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710180807.GD10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164432753@foobar.com>
	 <20050710180807.GD10904@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121076333.7502.61.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 11 Jul 2005 20:05:33 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-07-11 at 04:08, Pavel Machek wrote:
> Hi!
> 
> > +unsigned long suspend2_powerdown_method = 5; /* S5 = off */
> 
> Constants.....
> 
> > +	if (suspend2_powerdown_method == 3 ||
> > +	    suspend2_powerdown_method == 4)
> 
> Constants...
> 
> > +	if (suspend2_powerdown_method == 3 ||
> > +	    suspend2_powerdown_method == 4)
> 
> Constants...

Once per file is enough :>

> > +		suspend2_prepare_status(1, 0, "Ready to reboot.");
> > +		suspend2_prepare_status(1, 0, "Seeking to enter ACPI state");
> > +			suspend2_prepare_status(1, 0, "Preparing to enter ACPI state failed. Using normal powerdown.");
> > +			suspend2_prepare_status(1, 0, "Suspending devices failed. Using normal powerdown.");
> > +			suspend2_prepare_status(1, 0, "Entering ACPI state failed. Using normal powerdown.");
> > +		suspend2_prepare_status(1, 0, "Powering down.");
> 
> Too many magical constants here... Plus I don't really like your own
> logging subsystem.

The first parameter isn't needed anymore - gone. Second one changed to
an enum DONT_CLEAR_BAR | CLEAR_BAR.

Not liking it - that's alright there's some code you've written that I
don't like either :>

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

