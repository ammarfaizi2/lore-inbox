Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVGGSPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVGGSPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVGGSPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:15:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:23993 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261473AbVGGSPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:15:40 -0400
Date: Thu, 7 Jul 2005 11:15:30 -0700
From: Greg KH <greg@kroah.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: "Timothy R. Chavez" <tinytim@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Message-ID: <20050707181530.GB21072@kroah.com>
References: <1120668881.8328.1.camel@localhost> <200507061523.11468.tinytim@us.ibm.com> <20050706235008.GA9985@kroah.com> <200507062133.05827.sgrubb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507062133.05827.sgrubb@redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 09:33:05PM -0400, Steve Grubb wrote:
> On Wednesday 06 July 2005 19:50, Greg KH wrote:
> > As inotify works off of open file descriptors, yes, this is true. ?But,
> > again, if you think this is really important, then why not just work
> > with inotify to provide that kind of support to it?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110265021327578&w=2
> 
> I think Tim was told not to dig into inotify.

That was over 6 months ago.  Things change :)

> A lot of effort has been put into testing the code Tim has presented
> with review from several kernel developers (listed in the cc). They
> too should step up and give their opinion on this.

Sure, be glad to listen to them.

> I want to believe questions were asked about this last December when we were 
> starting into this effort. I think the conclusion from the inotify people was 
> for us to proceed and then when we know what we really want, we can refactor 
> should anything be in common.

I fail to see any refactoring here, why not make your patch rely on
theirs?

> > I suggest you work together with the inotify developers to hash out your
> > differences, as it sounds like you are duplicating a lot of the same
> > functionality.
> 
> Maybe yes and no. Now that the fs audit code is out, I think we can spot 
> commonality. The only common piece that I can think of is just the hook.

That's a good place to start.

> The whole rest of it is different. I hope the inotify people comment
> on this to see if there is indeed something that should be refactored.

I realize your userspace access is different, yet I do not believe yet
that it should be this way.

> > Do you have any documetation or example userspace code that shows how to
> > use this auditfs interface you have created?
> 
> people.redhat.com/sgrubb/audit

No documentation on the auditfs interface :(

> The audit package is currently distributed in Fedora Core 4. The code to use 
> Tim's fs audit code is in the user space app, but is waiting for the kernel 
> pieces.

So the userspace package in FC4 will not use auditfs?

thanks,

greg k-h
