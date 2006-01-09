Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWAIDbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWAIDbh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWAIDbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:31:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:56996 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751207AbWAIDbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:31:36 -0500
Date: Sun, 8 Jan 2006 19:30:57 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Paul Mackerras <paulus@samba.org>
Subject: Re: [GIT PATCH] PCI patches for 2.6.15
Message-ID: <20060109033057.GA2214@kroah.com>
References: <20060106063716.GA4425@kroah.com> <20060106180833.GA14235@kroah.com> <1136774203.30123.103.camel@localhost.localdomain> <1136774659.30123.107.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136774659.30123.107.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 01:44:18PM +1100, Benjamin Herrenschmidt wrote:
> 
> > Hi Greg, what patches specifically have problems ? Paul is just back
> > from vacation and we are trying to catch up with merging the tons of
> > pending powerpc stuffs, but we have a couple of requirements with things
> > in this list, notably my small export of pci_cfg_space_size() which
> > should be trivial, but also Linas error recovery stuff... So if one of
> > these is causing problems, we need to know right now as it means we have
> > to rebase.
> 
> BTW. I looked a linux-pci and only saw 2 complaints about the e1000 and
> sym2 driver patches to implement error recovery. I suppose you could
> just drop those 2 and keep the infrastructure in. However, I'm a bit
> annoyed because Linas did post those patches (and several times I think)
> to the relevant lists, and possibly the maintainers (not sure about
> that) and no comment was ever made...

I also got complaints about a number of the pci_register_driver()
changes, and I was reminded that some of the other patches break some
big IBM boxes in bad ways.

> I find it fairly annoying (and that's not the first time that happens)
> that a major piece of work gets posted publically several times, nobody
> bothers to comment, and by the time it gets send for merging upstream,
> suddenly, people wakeup from all over the place NAK'ing it for all sort
> of reasons, mostly claiming it wasn't properly reviewed by the
> appropriate maintainers...

Heh, it's not the first time, and will not be the last :)

I'll be reposting the series to Linus tomorrow.  I'll include your
export patch, and the core pci error handling changes, so you don't need
to worry about your tree.

thanks,

greg k-h
