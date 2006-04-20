Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWDTTgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWDTTgF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWDTTgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:36:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:39557 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751131AbWDTTgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:36:03 -0400
Date: Thu, 20 Apr 2006 12:34:23 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       Christoph Hellwig <hch@infradead.org>, tonyj@suse.de,
       James Morris <jmorris@namei.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make security_ops EXPORT_SYMBOL_GPL()
Message-ID: <20060420193423.GA8456@kroah.com>
References: <1145536791.16456.37.camel@moss-spartans.epoch.ncsc.mil> <20060420150037.GA30353@kroah.com> <1145542811.3313.94.camel@moss-spartans.epoch.ncsc.mil> <20060420161552.GA1990@kroah.com> <20060420162309.GA18726@infradead.org> <1145550897.3313.143.camel@moss-spartans.epoch.ncsc.mil> <20060420164651.GA2439@kroah.com> <1145552412.3313.150.camel@moss-spartans.epoch.ncsc.mil> <20060420170153.GA3237@kroah.com> <Pine.LNX.4.64.0604201104510.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604201104510.3701@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 11:08:23AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 20 Apr 2006, Greg KH wrote:
> >
> > Some closed source modules are taking advantage of the fact that the
> > security_ops variable is available to them, so they are using it to hook
> > into parts of the kernel that should only be available to "real" users
> > of the LSM interface (which is required to be under the GPL.)
> 
> I'm really not going to apply this.
> 
> It's insane. 
> 
> "security_ops" is used by _anything_ that uses the inline functions in 
> <linux/security.h>, which suddenly means that a non-GPL module cannot use 
> _any_ of the standard security tests. That's insane.

Ah, doh, you are right, sorry about that.

> If people want to remove security_ops, that's fine (not for 2.6.17, but 
> assuming you guys can come to some reasonable agreement, at some later 
> date). But turning it into a GPL-only, but leaving all the infrastructure 
> requiring it is not.

Fair enough, I'll work toward removing security_ops so that it is no
longer needed at all.

thanks,

greg k-h
