Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUG0HQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUG0HQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 03:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266305AbUG0HQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 03:16:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:44685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266304AbUG0HOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:14:46 -0400
Date: Tue, 27 Jul 2004 00:13:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, dipankar@in.ibm.com
Subject: Re: [patch] Use kref for struct file.f_count refcounter
Message-Id: <20040727001317.5c313b2d.akpm@osdl.org>
In-Reply-To: <20040727065528.GB1270@obelix.in.ibm.com>
References: <20040726150312.GJ1231@obelix.in.ibm.com>
	<20040726223036.281106c5.akpm@osdl.org>
	<20040727065528.GB1270@obelix.in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
>
> On Mon, Jul 26, 2004 at 10:30:36PM -0700, Andrew Morton wrote:
> > Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
> > >
> > > This patch makes use of the kref api for the 
> > >  struct file.f_count refcounter.  This depends
> > >  on the new kref apis kref_read and kref_put_last
> > >  added by means of my earlier patch today.
> > 
> > Sorry, but I can't really see how this improves anything.  It'll slow
> > things down infinitesimally and it forces the reader to look elsewhere in
> > the tree to see what's going on.
> > 
> 
> It doesn't improve anything in terms of performance or anything.  It just
> makes use of the kref api for refcounting.  My next patchset will be to
> extend the kref api to do lockfree refcounting, and eliminate
> use of files_struct.file_lock on the reader side (lock free fd lookup) .  

That would have been a useful thing to have mentioned in the description of
these patches, no?

> I can do a patch to just extend kref api for lockfree refcounting and
> use them for for the lock free fd lookup patch directly if you like to see
> it that way.

uh, whatever you think is best will suit at this time.

Please send all the patches, (as in: every single one) at the same time,
with complete descriptions.  Thanks.

