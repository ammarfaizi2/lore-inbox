Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVBVS7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVBVS7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 13:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVBVS7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:59:18 -0500
Received: from galileo.bork.org ([134.117.69.57]:17604 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261281AbVBVS7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:59:15 -0500
Date: Tue, 22 Feb 2005 13:59:15 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, mingo@elte.hu, raybry@sgi.com,
       linux-kernel@vger.kernel.org, hilgeman@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-ID: <20050222185915.GP26705@localhost>
References: <20050214154431.GS26705@localhost> <20050214193704.00d47c9f.pj@sgi.com> <20050221192721.GB26705@localhost> <20050221134220.2f5911c9.akpm@osdl.org> <421A607B.4050606@sgi.com> <20050221144108.40eba4d9.akpm@osdl.org> <20050222075304.GA778@elte.hu> <20050222032633.5cb38abb.pj@sgi.com> <20050222104535.0b3a3c65.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222104535.0b3a3c65.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Feb 22, 2005 at 10:45:35AM -0800, Andrew Morton wrote:
> Paul Jackson <pj@sgi.com> wrote:
> >
> >  As Martin wrote, when he submitted this patch:
> >  > The motivation for this patch is for setting up High Performance
> >  > Computing jobs, where initial memory placement is very important to
> >  > overall performance.
> > 
> >  Any left over cache is wrong, for this situation.
> 
> So...  Cannot the applicaiton remove all its pagecache with posix_fadvise()
> prior to exitting?

I think Paul's referring to pagecache (as well as other caches) that are
on the node from other uses, not necessarily another HPC job that has
recently terminated.

mh

-- 
Martin Hicks   ||   Silicon Graphics Inc.   ||   mort@sgi.com
