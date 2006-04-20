Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWDTQRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWDTQRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWDTQRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:17:20 -0400
Received: from ns.suse.de ([195.135.220.2]:59325 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751117AbWDTQRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:17:19 -0400
Date: Thu, 20 Apr 2006 09:15:52 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: tonyj@suse.de, James Morris <jmorris@namei.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Removing EXPORT_SYMBOL(security_ops) (was Re: Time to remove LSM)
Message-ID: <20060420161552.GA1990@kroah.com>
References: <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> <20060419154011.GA26635@kroah.com> <Pine.LNX.4.64.0604191221100.4408@d.namei> <20060419181015.GC11091@kroah.com> <1145536791.16456.37.camel@moss-spartans.epoch.ncsc.mil> <20060420150037.GA30353@kroah.com> <1145542811.3313.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145542811.3313.94.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 10:20:11AM -0400, Stephen Smalley wrote:
> On Thu, 2006-04-20 at 08:00 -0700, Greg KH wrote:
> > I agree.  In looking over the code some more, I'm trying to figure out
> > why we are exporting that variable at all.  Is it because of people
> > wanting to stack security modules?
> > 
> > I see selinux code using it, but you are always built into the kernel,
> > right?  So unexporting it would not be an issue to you.
> 
> Various in-tree modules (e.g. ext3) call security hooks via the static
> inlines and end up referencing security_ops directly.  We'd have to wrap
> all such hooks in the same manner as capable and permission.

Ah, and people like making their file systems as modules :(

> Although I was actually talking about eliminating security_ops, not just
> un-exporting it ;)

Yes, that would be even better, and solve some of the recent complaints
that people have with the lsm interface.

thanks,

greg k-h
