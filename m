Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSHHEiy>; Thu, 8 Aug 2002 00:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSHHEiy>; Thu, 8 Aug 2002 00:38:54 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:17333 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315279AbSHHEix>; Thu, 8 Aug 2002 00:38:53 -0400
Date: Thu, 8 Aug 2002 10:11:45 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: [Lse-tech] [patch] Scalable statistics counters with /proc reporting
Message-ID: <20020808101145.C12301@in.ibm.com>
References: <20020807142227.B12301@in.ibm.com> <20020807100216.A27321@infradead.org> <3D516EB5.E8669146@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D516EB5.E8669146@zip.com.au>; from akpm@zip.com.au on Wed, Aug 07, 2002 at 12:02:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 12:02:14PM -0700, Andrew Morton wrote:
> Christoph Hellwig wrote:
> > 
> > ...
> > Also the /proc-based implementation is really ugly.  It should be moved
> > over to the seq_file interface at least, a simple ramfs-style own
> > filesystem ("stats" filesystem type) would be the cleanest solution.
> 
> I'd suggest that it be just a single stat counter per /proc
> file.  A simple sprintf is fine for that.
> 
> If it's necessary to write a new filesystem to just export a bunch
> of integers to userspace then something is seriously wrong.

Yes, that was how my previous release worked.  But Rik wanted to be able 
to group a bunch of counters into a single /proc file for his use.   
Rik, your comments please... what do you prefer? current /proc style, 
seq_file, or the earlier "one counter per /proc" style? 

Thanks,
Kiran
