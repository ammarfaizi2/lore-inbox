Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWEVKvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWEVKvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 06:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWEVKvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 06:51:47 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:40966 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1750742AbWEVKvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 06:51:46 -0400
Date: Mon, 22 May 2006 18:50:25 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Christoph Hellwig <hch@lst.de>
cc: Andrew Morton <akpm@osdl.org>, pbadari@us.ibm.com, bcrl@kvack.org,
       cel@citi.umich.edu, zach.brown@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Remove readv/writev methods and use aio_read/aio_write
 instead
In-Reply-To: <20060522103246.GA28133@lst.de>
Message-ID: <Pine.LNX.4.64.0605221846430.27006@raven.themaw.net>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
 <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
 <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>
 <1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com>
 <20060521180037.3c8f2847.akpm@osdl.org> <20060522053450.GA22210@lst.de>
 <20060522022917.3e563261.akpm@osdl.org> <20060522023519.2541f082.akpm@osdl.org>
 <20060522103246.GA28133@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-2.599,
	required 5, autolearn=not spam, BAYES_00 -2.60)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2006, Christoph Hellwig wrote:

> On Mon, May 22, 2006 at 02:35:19AM -0700, Andrew Morton wrote:
> > The loop driver plays with file_operations.write() also.  The code should
> > be reviewed and tested against filesystems which use LO_FLAGS_USE_AOPS as
> > well as against those which do not, please.
> 
> The LO_FLAGS_USE_AOPS stuff is broken, please drop it from -mm.  I
> explained to the RedHAt guy in detail on how to get it right.
> 
> That beeing said the bu isn't autofs using ->write directly which is
> done in a lot of places but the pipe code not setting it to
> do_sync_write.
> 

If there's anything I need to do to help just point me in the right 
direction.

The brief look at the patch that I had left me thinking the read and write 
methods were not set but I probably missed something obvious and didn't 
return to look again.

Ian

