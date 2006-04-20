Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWDTMvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWDTMvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 08:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWDTMvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 08:51:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:40386 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750855AbWDTMvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 08:51:42 -0400
Date: Thu, 20 Apr 2006 07:51:39 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Greg KH <greg@kroah.com>, James Morris <jmorris@namei.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060420125139.GE18604@sergelap.austin.ibm.com>
References: <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> <20060419154011.GA26635@kroah.com> <Pine.LNX.4.64.0604191221100.4408@d.namei> <20060419181015.GC11091@kroah.com> <1145536791.16456.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145536791.16456.37.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Wed, 2006-04-19 at 11:10 -0700, Greg KH wrote:
> > On Wed, Apr 19, 2006 at 12:33:24PM -0400, James Morris wrote:
> > > The LSM interface is also being abused by several proprietary kernel 
> > > modules, some of which are not even security related.  In one case, 
> > > there's code which dangerously revectors SELinux with a shim layer 
> > > designed to try and bypass the GPL.  Some of this is a response to 
> > > unexporting the syscall table, where projects which abused that have now 
> > > switched to LSM.
> > 
> > I agree that this is happening today.  Which makes me wonder, why is the
> > variable "security_ops" exported through "EXPORT_SYMBOL()" and not
> > "EXPORT_SYMBOL_GPL()"?  It seems that people are taking advantage of
> > this and changing it would help slow them down a bit.
> > 
> > Chris, would you take a patch to change this?
> 
> Seems like a rather weak mechanism.   Compared to eliminating
> security_ops altogether.

Yup, that'll achieve the goal as well  :-)

-serge
