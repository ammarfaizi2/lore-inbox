Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWFAQGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWFAQGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWFAQGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:06:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030216AbWFAQGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:06:38 -0400
Date: Thu, 1 Jun 2006 09:10:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Barry Scott <barry.scott@onelan.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: broadcom 5752 in HP dc7600U works on 2.6.13 but does not
 working on 2.6.16
Message-Id: <20060601091048.bffcf072.akpm@osdl.org>
In-Reply-To: <447EBCF9.8090208@onelan.co.uk>
References: <4469E709.7080501@onelan.co.uk>
	<20060522035943.7829ee32.akpm@osdl.org>
	<447EB970.8030005@onelan.co.uk>
	<20060601030615.41b70b1f.akpm@osdl.org>
	<447EBCF9.8090208@onelan.co.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 11:10:01 +0100
Barry Scott <barry.scott@onelan.co.uk> wrote:

> Andrew Morton wrote:
> > On Thu, 01 Jun 2006 10:54:56 +0100
> > Barry Scott <barry.scott@onelan.co.uk> wrote:
> >
> >   
> ...
> >> I'm willing to help get this fixed. I'm happy working inside kernels and 
> >> drivers
> >> but will need some guidance to know where to focus to track this down.
> >>     
> >
> > ACPI, most likely.
> >
> >   
> >> The obvious problem is solve is why are no interrupts being received by
> >> the tg3.c code.
> >>
> >> Which kernel should I use to debug this? 2.6.17 latest RC?
> >> Which debug options do you suggest I turn on to get closer to the problem?
> >> What information should I collect?
> >>     
> >
> > A git-bisect search would be a suitable way of finding out where it broke.
> >
> > But then, we don't know if this machine has _ever_ worked with IO-APIC's
> > enabled, do we?
> >   
>  From the point of view of APIC its not a regression.

OK.

> Isn't the way forward to find out why it does not work now as there is no
> old code that did work to compare to?

If you can enable the apic in earlier kernels and if that works OK then
bisection is an option.  Frankly, it's more likely to create a result,
mainly because we don't have an "apic maintainer" as such - the code in
there is largely the result of a lot of drive-by hacks.

So the question isn't so much "what information should I collect" as "to
whom should I send it".  And yes, this is a problem.
