Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWDTUP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWDTUP5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWDTUP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:15:57 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:26240 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750953AbWDTUP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:15:56 -0400
Date: Thu, 20 Apr 2006 13:14:38 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Greg KH <greg@kroah.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, tonyj@suse.de,
       James Morris <jmorris@namei.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Removing EXPORT_SYMBOL(security_ops) (was Re: Time to remove LSM)
Message-ID: <20060420201438.GB3828@sorel.sous-sol.org>
References: <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> <20060419154011.GA26635@kroah.com> <Pine.LNX.4.64.0604191221100.4408@d.namei> <20060419181015.GC11091@kroah.com> <1145536791.16456.37.camel@moss-spartans.epoch.ncsc.mil> <20060420150037.GA30353@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420150037.GA30353@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry if this is repeat, my mail server is dying, and mail is coming in
seriously out of order)

* Greg KH (greg@kroah.com) wrote:
> I agree.  In looking over the code some more, I'm trying to figure out
> why we are exporting that variable at all.  Is it because of people
> wanting to stack security modules?

No, the issue is simple.  There's a all the static inlines which use
security_ops, and some of them are placed in modular code.

thanks,
-chris
