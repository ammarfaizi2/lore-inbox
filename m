Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVAJVuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVAJVuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVAJVd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:33:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:272 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262672AbVAJV3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:29:41 -0500
Date: Mon, 10 Jan 2005 21:29:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stephen_pollei@comcast.net
Subject: Re: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS
Message-ID: <20050110212932.D10365@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@stusta.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	stephen_pollei@comcast.net
References: <20050110184307.GB2903@stusta.de> <1105382033.12054.90.camel@localhost.localdomain> <41E2F1BD.1020407@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41E2F1BD.1020407@drzeus.cx>; from drzeus-list@drzeus.cx on Mon, Jan 10, 2005 at 10:21:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 10:21:01PM +0100, Pierre Ossman wrote:
> Alan Cox wrote:
> > On Llu, 2005-01-10 at 18:43, Adrian Bunk wrote:
> > 
> >>IMHO lists rejecting emails based on some non-standard extension don't 
> >>belong into MAINTAINERS.
> > 
> > 
> > Find out why someone is publishing records saying your mail isnt valid
> > instead of moaning here. If they are using SPF and you are not using any
> > strange extensions its fine. You or your provider appears to be
> > advertising that stusta.de doesn't use the mail relay you are using.
> > 
> 
> I think I've fixed the problem now. It wasn't that there were published 
> records for stusta.de, the problem was that the mail server couldn't 
> resolve your domain. For some reason everything from the DNS I'm using 
> to your DNS gets dropped. The mail server takes the paranoid route and 
> assumes the worst when it cannot contact dns servers (that's why you got 
> a 4xx, not a 5xx). I've now changed DNS which will hopefully solve the 
> issue.
> 
> As for dropping the mailing list out of MAINTAINERS then I'd prefer you 
> didn't (of course). But I will not remove the filters on the servers 
> since they remove a lot of spam. If that means it cannot be in 
> MAINTAINERS, then so be it.

You may wish to check the source port which your DNS servers are using
to perform lookups.  I've had a situation recently where someone was
unable to send me mail.  Upon investigation, I found that my name
servers couldn't resolve his domain, but plain 'dig' on the same box
could.

I've come across ISPs who think they should block DNS requests from
certain _source_ ports to "improve" their security, which may explain
what you're seeing.

If this is the case, I suggest Adrian finds a better ISP.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
