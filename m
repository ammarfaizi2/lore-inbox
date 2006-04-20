Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWDTMgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWDTMgL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 08:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWDTMgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 08:36:10 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:45560 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750873AbWDTMgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 08:36:09 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Greg KH <greg@kroah.com>
Cc: James Morris <jmorris@namei.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060419181015.GC11091@kroah.com>
References: <200604142301.10188.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
	 <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
	 <20060419154011.GA26635@kroah.com>
	 <Pine.LNX.4.64.0604191221100.4408@d.namei>
	 <20060419181015.GC11091@kroah.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 20 Apr 2006 08:39:51 -0400
Message-Id: <1145536791.16456.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 11:10 -0700, Greg KH wrote:
> On Wed, Apr 19, 2006 at 12:33:24PM -0400, James Morris wrote:
> > The LSM interface is also being abused by several proprietary kernel 
> > modules, some of which are not even security related.  In one case, 
> > there's code which dangerously revectors SELinux with a shim layer 
> > designed to try and bypass the GPL.  Some of this is a response to 
> > unexporting the syscall table, where projects which abused that have now 
> > switched to LSM.
> 
> I agree that this is happening today.  Which makes me wonder, why is the
> variable "security_ops" exported through "EXPORT_SYMBOL()" and not
> "EXPORT_SYMBOL_GPL()"?  It seems that people are taking advantage of
> this and changing it would help slow them down a bit.
> 
> Chris, would you take a patch to change this?

Seems like a rather weak mechanism.   Compared to eliminating
security_ops altogether.

-- 
Stephen Smalley
National Security Agency

