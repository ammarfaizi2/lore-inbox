Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWDQTxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWDQTxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 15:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWDQTxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 15:53:17 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35521 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750811AbWDQTxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 15:53:17 -0400
Date: Mon, 17 Apr 2006 12:51:46 -0700
From: Greg KH <greg@kroah.com>
To: James Morris <jmorris@namei.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060417195146.GA8875@kroah.com>
References: <200604021240.21290.edwin@gurde.com> <200604072138.35201.edwin@gurde.com> <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604171454070.17563@d.namei>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 03:20:55PM -0400, James Morris wrote:
> On Mon, 17 Apr 2006, Christoph Hellwig wrote:
> 
> > > Or, better, remove LSM itself ;)
> > 
> > Seriously that makes a lot of sense.  All other modules people have come up
> > with over the last years are irrelevant and/or broken by design.
> 
> It's been nearly a year since I proposed this, and we've not seen any 
> appropriate LSM modules submitted in that time.
> 
> See
> http://thread.gmane.org/gmane.linux.kernel.lsm/1120
> http://thread.gmane.org/gmane.linux.kernel.lsm/1088
> 
> The only reason I can see to not delete it immediately is to give BSD 
> secure levels users a heads-up, although I thought it was already slated 
> for removal.  BSD secure levels is fundamentally broken and should 
> never have gone into mainline.

I agree about the BSD secure levels code, it has a known reported
security problem, with no response by its maintainers.  On that aspect
alone, it should be removed.

But for removing LSM entirely, I'm starting to like your patch.  It's
been a very long time and so far, only out-of-tree LSMs are present,
with no public statements about getting them submitted into the main
kernel tree.  And, I think almost all of the out-of-tree modules already
need other kernel patches to get their code working properly, so what's
a few more hooks needed...

/me pokes the bushes to flush out the people lurking

Oh, but do remember, the main goal of LSM was to stop people from
arguing about different security models.  Now that it is in, we haven't
had any bickering about different types of things that should go into
mainline, all with different models and usages.  Everyone gets to play
in their own sandbox and not worry about anyone else.  If the LSM
interface was to go away, that problem would start happening again, and
I don't think we want to go there.

So, I think the only way to be able to realisticly keep the LSM
interface, is for a valid, working, maintained LSM-based security model
to go into the kernel tree.  So far, I haven't seen any public posting
of patches that meet this requirement :(

thanks,

greg k-h
