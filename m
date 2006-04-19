Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWDSTdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWDSTdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDSTdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:33:40 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16003 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751157AbWDSTdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:33:39 -0400
Date: Wed, 19 Apr 2006 12:33:06 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Greg KH <greg@kroah.com>
Cc: James Morris <jmorris@namei.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060419193306.GL4917@sorel.sous-sol.org>
References: <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> <20060419154011.GA26635@kroah.com> <Pine.LNX.4.64.0604191221100.4408@d.namei> <20060419181015.GC11091@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419181015.GC11091@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
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

I don't see any reason not to.
