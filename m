Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934366AbWLAH3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934366AbWLAH3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934424AbWLAH3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:29:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34994 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S934293AbWLAH3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:29:18 -0500
Date: Thu, 30 Nov 2006 23:29:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: ltuikov@yahoo.com
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Infinite retries reading the partition table
Message-Id: <20061130232916.6cbd1408.akpm@osdl.org>
In-Reply-To: <117439.97789.qm@web31803.mail.mud.yahoo.com>
References: <20061130214716.6306a586.akpm@osdl.org>
	<117439.97789.qm@web31803.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 22:34:57 -0800 (PST)
Luben Tuikov <ltuikov@yahoo.com> wrote:

> --- Andrew Morton <akpm@osdl.org> wrote:
> > On Wed, 29 Nov 2006 17:22:48 -0800 (PST)
> > Luben Tuikov <ltuikov@yahoo.com> wrote:
> > 
> > > Suppose reading sector 0 always reports an error,
> > > sense key HARDWARE ERROR.
> > > 
> > > What I'm observing is that the request to read sector 0,
> > > reading partition information, is retried forever, ad infinitum.
> > > 
> > > Does anyone have a patch to resolve this? (2.6.19-rc6)
> > > 
> > 
> > Please send a backtrace so we can see where the offending loop occurs.
> 
> I posted a patch to linux-scsi

hm.  Does sending patches to linux-scsi get them applied?  It might, I
don't know.

> which resolves this issue:
> http://marc.theaimsgroup.com/?l=linux-scsi&m=116485834119885&w=2

That looks like it prevents the IO error.  But why was an IO error causing
an infinite loop?   What piece of code was initiating the retries?

