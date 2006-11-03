Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753137AbWKCGZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbWKCGZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 01:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbWKCGZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 01:25:27 -0500
Received: from pat.uio.no ([129.240.10.4]:56221 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1753134AbWKCGZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 01:25:26 -0500
Subject: Re: [PATCH 2/3] fsstack: Generic get/set lower object functions
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: Mark Williamson <mark.williamson@cl.cam.ac.uk>,
       linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Michael Halcrow <mhalcrow@us.ibm.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20061103035130.GC13499@filer.fsl.cs.sunysb.edu>
References: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu>
	 <1162483565.6299.98.camel@lade.trondhjem.org>
	 <20061103032702.GB13499@filer.fsl.cs.sunysb.edu>
	 <200611030345.51167.mark.williamson@cl.cam.ac.uk>
	 <20061103035130.GC13499@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 01:25:03 -0500
Message-Id: <1162535103.5635.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.205, required 12,
	autolearn=disabled, AWL 1.66, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 22:51 -0500, Josef Sipek wrote:
> On Fri, Nov 03, 2006 at 03:45:50AM +0000, Mark Williamson wrote:
> > > > Why are you defining all these structs that are just wrapping unions?
> > >
> > > The reason for the union is simple...
> ...
> > I guess that having a union foo * rather than a struct foo * would be a bit 
> > unconventional in the kernel.  The named struct / anonymous union combo does 
> > hide the union as merely an implementation detail, which is nice.  Was this 
> > your motivation?
> 
> That's exactly it. Save space & hide the details.

Why? What is so special about the details that you need to hide them?
This is a union that will always be part of a structure anyway.

Trond

