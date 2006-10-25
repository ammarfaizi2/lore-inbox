Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWJYWDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWJYWDB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 18:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWJYWDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 18:03:01 -0400
Received: from c60.cesmail.net ([216.154.195.49]:35845 "EHLO c60.cesmail.net")
	by vger.kernel.org with ESMTP id S1751695AbWJYWDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 18:03:00 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Pavel Roskin <proski@gnu.org>
To: David Weinehall <tao@acc.umu.se>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20061025213355.GG23256@vasa.acc.umu.se>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
	 <1161810392.3441.60.camel@dv>  <20061025213355.GG23256@vasa.acc.umu.se>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 18:02:58 -0400
Message-Id: <1161813778.3441.84.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 23:33 +0200, David Weinehall wrote:

> No matter how the legal situation looks like: do we *want* to support
> drivers that use an API totally alien to Linux concepts?

The word "support" is overloaded.  I think tainting was striking the
perfect balance between the two meanings.  The driver would work, but
the kernel developers could ignore problems with the driver.

What is going on now is making sure that the driver doesn't work.  At
least that's my understanding of Alan's intention not to allow code
loading for modules that have used GPL-only symbols.

And that's what I think is way over the top.  It's akin looking for
process called "wine" (or detecting it by its behavior) and denying it
access to some syscalls.

> Personally I feel that no matter if they are legal or not, we should not
> cater to such drivers in the first place.  If it's trickier to use
> Windows API-drivers under Linux than to write a native Linux driver,
> big deal...  We don't want Windows-drivers.  We want native drivers.

The only non-native part of ndiswrapper is NDIS, as opposed to bare
hardware access.  ndiswrapper implements quite a lot of functionality in
the free code.

Discouraging the ndiswrapper developer is especially unfair because he
did much better job at supporting such features as WPA, compared to what
some of us, myself included, did with the free drivers.

I'm not against free and fully open drivers, but they won't appear
overnight.  Sometimes ndiswrapper is a good starting point to understand
what the hardware can do and whether it's functional at all.  It could
also be used for reverse engineering.

-- 
Regards,
Pavel Roskin

