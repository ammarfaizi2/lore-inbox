Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWEKLGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWEKLGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 07:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWEKLGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 07:06:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59267 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030222AbWEKLGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 07:06:32 -0400
Date: Thu, 11 May 2006 04:00:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: mikem@beardog.cca.cpqcorp.net, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] make kernel ignore bogus partitions
Message-Id: <20060511040014.66ea16fc.akpm@osdl.org>
In-Reply-To: <20060509224848.GA29754@apps.cwi.nl>
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net>
	<20060509124138.43e4bac0.akpm@osdl.org>
	<20060509224848.GA29754@apps.cwi.nl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <Andries.Brouwer@cwi.nl> wrote:
>
> On Tue, May 09, 2006 at 12:41:38PM -0700, Andrew Morton wrote:
> 
> > > +		if (from+size-1 > get_capacity(disk)) {
> > > +			printk(" %s: p%d exceeds device capacity, ignoring.\n", 
> > > +				disk->disk_name, p);
> > > +			continue;
> > > +		}
> > >  		add_partition(disk, p, from, size);
> 
> > Shouldn't that be
> > 
> > 	if (from+size > get_capacity(disk)) {
> > 
> > ?
> 
> Ha, you are awake.

Opinions differ.

> Yes, it should.
> And no "ignoring". And no "continue". E.g.:
> 
> 	printk(" %s: warning: p%d exceeds device capacity.\n", ...);
> 

So you're saying that after detecting this inconsistency we should proceed
to use the partition anyway?

For what reason?
