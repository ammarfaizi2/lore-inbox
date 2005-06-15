Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVFOVDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVFOVDB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVFOVA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:00:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261578AbVFOU7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:59:41 -0400
Date: Wed, 15 Jun 2005 13:59:26 -0700
From: Chris Wright <chrisw@osdl.org>
To: serue@us.ibm.com
Cc: James Morris <jmorris@redhat.com>, Reiner Sailer <sailer@watson.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@wirex.com>, Tom Lendacky <toml@us.ibm.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       Emily Rattlif <emilyr@us.ibm.com>, Kylene Hall <kylene@us.ibm.com>
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
Message-ID: <20050615205926.GP9046@shell0.pdx.osdl.net>
References: <1118846413.2269.18.camel@secureip.watson.ibm.com> <Xine.LNX.4.44.0506151601310.27162-100000@thoron.boston.redhat.com> <20050615204936.GA3517@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615204936.GA3517@serge.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* serue@us.ibm.com (serue@us.ibm.com) wrote:
> Since IMA provides support for a new type of security policy,
> specifically remote system integrity verification, I don't see
> where LSM shouldn't necessarily be used.
> 
> I'm also curious about the current kernel development approach:
> On the one hand, when filesystem auditing was introduced, Christoph
> asked whether inotify and audit should be merged because they hook
> some of the same places.  Can someone reconcile these points of view
> for me, please?  If Reiner goes ahead and moves the IMA code straight
> into the kernel, does anyone doubt that he'll be asked to merge it
> with LSM?

The primary purpose of the hooks is access control.  Some of them, of
course, are helpers to keep labels coherent.  IIRC, James objected
because the measurement data was simply collected from these hooks.
