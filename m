Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbUCPJvo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 04:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbUCPJvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 04:51:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:64180 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263808AbUCPJvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 04:51:42 -0500
Date: Tue, 16 Mar 2004 01:51:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: greg@kroah.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core update for 2.6.4
Message-Id: <20040316015141.062fecff.akpm@osdl.org>
In-Reply-To: <20040316070409.A28022@infradead.org>
References: <10793951494179@kroah.com>
	<1079395149503@kroah.com>
	<20040316070409.A28022@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Mar 15, 2004 at 03:59:09PM -0800, Greg KH wrote:
> > ChangeSet 1.1608.84.16, 2004/03/15 14:39:18-08:00, greg@kroah.com
> > 
> > kref: add kref structure to kernel tree.
> > 
> > Based on the kobject structure, but much smaller and simpler to use.
> 
> Didn't everyone who reviewed this say it's useless bloat.

No.

bix:/usr/src/25> wc -l include/linux/kref.h lib/kref.c
     32 include/linux/kref.h
     60 lib/kref.c
     92 total

bix:/usr/src/25> size lib/kref.o
   text    data     bss     dec     hex filename
    368       0       0     368     170 lib/kref.o

>   Andi even got
> so far as calling it obsfucation, given that hides simple things behind
> an overly complex and wastefull abstraction.

eh?  If there is any argument against this code it is that it is so simple
that the thing which it abstracts is not worth abstracting.  But given that
it is so unwasteful, this seems unimportant.


