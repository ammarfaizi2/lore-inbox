Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVA3Wo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVA3Wo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVA3Wo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:44:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32267 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261818AbVA3Woz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:44:55 -0500
Date: Sun, 30 Jan 2005 22:44:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild: shorthand ym2y, ym2m etc
Message-ID: <20050130224452.G25000@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20050130193733.GA8984@mars.ravnborg.org> <20050130195230.GA871@infradead.org> <20050130223926.GG14816@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050130223926.GG14816@mars.ravnborg.org>; from sam@ravnborg.org on Sun, Jan 30, 2005 at 11:39:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 11:39:26PM +0100, Sam Ravnborg wrote:
> On Sun, Jan 30, 2005 at 07:52:30PM +0000, Christoph Hellwig wrote:
> > 
> > obj-$(CONFIG_FB)$(CONFIG_PPC)		+= macmodes.o
> > 
> > would be a lot more obvious, but I'm not sure how to handle
> > it for the case where one of them evaluates to m
> 
> The real problem is when say CONFIG_FB are empty. Then kbuild will see:
> obj-$(CONFIG_PPC) which I doubt was what you wanted.
> 
> This can be fixed by changing Kconfig to evaluate all known symbols to
> either y,m,n - in contradiction to today where symbols that evaluate
> to n is left empty.

Isn't that rather hard to achieve, unless all Kconfig files (including
all architecture specific ones) are read?  Eg, CONFIG_PPC wouldn't
exist on ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
