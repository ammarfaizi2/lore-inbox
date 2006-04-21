Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWDURfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWDURfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 13:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWDURfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 13:35:34 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:19584 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932193AbWDURfd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 13:35:33 -0400
Date: Fri, 21 Apr 2006 10:34:39 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Stephen Smalley <sds@tycho.nsa.gov>,
       Christoph Hellwig <hch@infradead.org>, tonyj@suse.de,
       James Morris <jmorris@namei.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make security_ops EXPORT_SYMBOL_GPL()
Message-ID: <20060421173439.GC3061@sorel.sous-sol.org>
References: <1145542811.3313.94.camel@moss-spartans.epoch.ncsc.mil> <20060420161552.GA1990@kroah.com> <20060420162309.GA18726@infradead.org> <1145550897.3313.143.camel@moss-spartans.epoch.ncsc.mil> <20060420164651.GA2439@kroah.com> <1145552412.3313.150.camel@moss-spartans.epoch.ncsc.mil> <20060420170153.GA3237@kroah.com> <Pine.LNX.4.64.0604201104510.3701@g5.osdl.org> <20060420193423.GA8456@kroah.com> <20060421165050.GA11333@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421165050.GA11333@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Thu, Apr 20, 2006 at 12:34:23PM -0700, Greg KH wrote:
> > On Thu, Apr 20, 2006 at 11:08:23AM -0700, Linus Torvalds wrote:
> > > If people want to remove security_ops, that's fine (not for 2.6.17, but 
> > > assuming you guys can come to some reasonable agreement, at some later 
> > > date). But turning it into a GPL-only, but leaving all the infrastructure 
> > > requiring it is not.
> > 
> > Fair enough, I'll work toward removing security_ops so that it is no
> > longer needed at all.
> 
> Ok, that was pretty foolish of me to attempt.  We could move all of the
> inline functions in security.h to a .c file for when the LSM framework
> is enabled, but that might cause some slowdowns.  Although I remember
> that Kurt Garloff did some work in this area in the past, showing that
> moving these out of inline caused some improvements on ia64.

No, those patches didn't deinline anything.  Rather eliminated the
indirect call via sercurity_ops when possible.  I was actually in the
process of ressurecting those when this whole thread broke out.

> Anyway, for now I'm not going to worry about this, it isn't that
> important...

Agreed ;-)

thanks,
-chris
