Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262966AbVDBBpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbVDBBpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 20:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbVDBBpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 20:45:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:54472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262962AbVDBBpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 20:45:04 -0500
Subject: Re: [PATCH] Direct IO async short read bug followup
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, sebastien.dugue@bull.net,
       jean-pierre.dion@bull.net, gh@us.ibm.com, janetmor@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20050401172720.4a92a4e3.akpm@osdl.org>
References: <1111743607.1299.85.camel@frecb000686>
	 <20050325014307.4395012e.akpm@osdl.org>
	 <1111745400.1299.89.camel@frecb000686>
	 <20050325022416.01c2535b.akpm@osdl.org> <42442743.40600@us.ibm.com>
	 <1112404259.29841.19.camel@ibm-c.pdx.osdl.net>
	 <20050401172022.45d0cdd5.akpm@osdl.org>
	 <20050401172720.4a92a4e3.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1112406264.29841.33.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Apr 2005 17:44:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 17:27, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> >  >  --- linux-2.6.11.orig/fs/direct-io.c	2005-04-01 15:33:11.000000000 -0800
> >  >  +++ linux-2.6.11/fs/direct-io.c	2005-03-31 16:59:15.000000000 -0800
> >  >  @@ -66,6 +66,7 @@ struct dio {
> >  >   	struct bio *bio;		/* bio under assembly */
> >  >   	struct inode *inode;
> >  >   	int rw;
> >  >  +	ssize_t i_size;			/* i_size when submitted */
> > 
> >  I'll change this to loff_t, OK?
> 
> And I think local variable `transferred' can remain ssize_t.  Agree?

Yes.

Daniel

