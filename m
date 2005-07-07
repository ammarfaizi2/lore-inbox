Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVGGS4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVGGS4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVGGSxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:53:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25254 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261739AbVGGSv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:51:59 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Date: Thu, 7 Jul 2005 14:49:09 -0400
User-Agent: KMail/1.7.2
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
References: <1120668881.8328.1.camel@localhost> <200507062133.05827.sgrubb@redhat.com> <20050707181530.GB21072@kroah.com>
In-Reply-To: <20050707181530.GB21072@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071449.10271.sgrubb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 July 2005 14:15, Greg KH wrote:
> I fail to see any refactoring here, why not make your patch rely on
> theirs?

At the time this code was developed, inotify was not in the kernel. We would 
be patching against another patch that's not in the kernel.

> > The whole rest of it is different. I hope the inotify people comment
> > on this to see if there is indeed something that should be refactored.
>
> I realize your userspace access is different, yet I do not believe yet
> that it should be this way.

The problems that we are faced with are dictated by CAPP and other security 
profiles. The audit user space access has been in the kernel for over a year, 
so that's not really a good thing to go changing.

> No documentation on the auditfs interface :(

That's what Tim's email was providing. Its a new component.

> > The audit package is currently distributed in Fedora Core 4. The code to
> > use Tim's fs audit code is in the user space app, but is waiting for the
> > kernel pieces.
>
> So the userspace package in FC4 will not use auditfs?

Right. You get a few warnings due to missing functionality. If the kernel were 
patched with Tim's code, it all works as expected. We have worked out the 
user space access and that shouldn't be changing.

-Steve
