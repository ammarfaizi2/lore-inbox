Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030682AbWJKQ4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030682AbWJKQ4w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWJKQ4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:56:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030451AbWJKQ4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:56:51 -0400
Date: Wed, 11 Oct 2006 09:56:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Theodore Tso <tytso@mit.edu>, lkml <linux-kernel@vger.kernel.org>,
       shaggy@us.ibm.com, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: 2.6.19-rc1-mm1 (ext4 problem ?)
Message-Id: <20061011095639.ad8169f7.akpm@osdl.org>
In-Reply-To: <1160578934.1447.1.camel@dyn9047017100.beaverton.ibm.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<452C616D.7040701@us.ibm.com>
	<20061010210133.dda19d4c.akpm@osdl.org>
	<1160578934.1447.1.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 08:02:14 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> On Tue, 2006-10-10 at 21:01 -0700, Andrew Morton wrote: 
> > 
> > > Andrew Morton wrote:
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> > > >
> > > >
> > > > - Added the ext4 filesystem.  Quick usage instructions:
> > > >
> > > >   - Grab updated e2fsprogs from
> > > >     ftp://ftp.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs-interim/
> > > >   
> 
> ext4 did not survive my simple stress tests. 
> 
> I ran 4 copies of fsx on ext4dev filesystem (without extents) +
> 4 copies of fsx on ext4dev (with extents). 
> 
> Machine hung after running for few hours. There are 4 fsx sigsegv
> messages on the console and the last message on the console is
> 
> do_IRQ: 0.62 No irq handler for vector
> 

Quite a few people are hitting that - it's related to Eric's recent
IRQ/APIC-routing changes.

I don't know why that would cause fsx to get a sigsegv though.
