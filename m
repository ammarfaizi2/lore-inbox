Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbUB2XBO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 18:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUB2XBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 18:01:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:33496 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262174AbUB2XBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 18:01:13 -0500
Date: Sun, 29 Feb 2004 15:02:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: jmorris@redhat.com, sds@epoch.ncsc.mil, linux-kernel@vger.kernel.org
Subject: Re: [SELINUX] Handle fuse binary mount data.
Message-Id: <20040229150213.3ebd7ef9.akpm@osdl.org>
In-Reply-To: <20040229215542.A31786@infradead.org>
References: <Xine.LNX.4.44.0402291637360.22151-100000@thoron.boston.redhat.com>
	<20040229215542.A31786@infradead.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Feb 29, 2004 at 04:38:51PM -0500, James Morris wrote:
> >  	/* Ignore these fileystems with binary mount option data. */
> > -	if (!strcmp(name, "coda") ||
> > -	    !strcmp(name, "afs") || !strcmp(name, "smbfs"))
> > +	if (!strcmp(name, "coda") || !strcmp(name, "afs") ||
> > +	    !strcmp(name, "smbfs") || !strcmp(name, "fuse"))
> >  		goto out;
> 
> Umm, binary mount data is bad enough, but hardcoding filesystem-depend code
> in selinux is just bogus..

Yes, it's rather awkward.

Could we do something such as passing a new mount flag in from userspace? 
Add a new flag alongside MS_SYNCHRONOUS, MS_REMOUNT and friends?
