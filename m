Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVDFEvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVDFEvx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 00:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVDFEvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 00:51:52 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:39390 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262027AbVDFEvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 00:51:39 -0400
Date: Wed, 6 Apr 2005 10:31:07 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
Subject: Re: [RFC] Add support for semaphore-like structure with support for asynchronous I/O
Message-ID: <20050406050107.GB6200@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20050330143409.04f48431.akpm@osdl.org> <1112224663.18019.39.camel@lade.trondhjem.org> <1112309586.27458.19.camel@lade.trondhjem.org> <20050331161350.0dc7d376.akpm@osdl.org> <1112318537.11284.10.camel@lade.trondhjem.org> <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com> <20050404162216.GA18469@kvack.org> <1112637395.10602.95.camel@lade.trondhjem.org> <20050405154641.GA27279@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405154641.GA27279@kvack.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 11:46:41AM -0400, Benjamin LaHaise wrote:
> On Mon, Apr 04, 2005 at 01:56:35PM -0400, Trond Myklebust wrote:
> > IOW: the current semaphore implementations really all need to die, and
> > be replaced by a single generic version to which it is actually
> > practical to add new functionality.
> 
> I can see that goal, but I don't think introducing iosems is the right 
> way to acheive it.  Instead (and I'll start tackling this), how about 
> factoring out the existing semaphore implementations to use a common 
> lib/semaphore.c, much like lib/rwsem.c?  The iosems can be used as a 
> basis for the implementation, but we can avoid having to do a giant 
> s/semaphore/iosem/g over the kernel tree.

That would be really neat, if you can get to it.

Regards
Suparna

> 
> > Failing that, it is _much_ easier to convert the generic code that needs
> > to support aio to use a new locking implementation and then test that.
> > It is not as if conversion to aio won't involve changes to the code in
> > the area surrounding those locks anyway.
> 
> Quite true.  There's a lot more work to do in this area, and these common 
> primatives are needed to make progress.  Someone at netapp sent me an 
> email yesterday asking about aio support in NFS, so there is some demand 
> out there.  Cheers,
> 
> 		-ben
> -- 
> "Time is what keeps everything from happening all at once." -- John Wheeler
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

