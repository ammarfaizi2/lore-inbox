Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271233AbTHHFmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 01:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271235AbTHHFmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 01:42:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34238 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S271233AbTHHFmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 01:42:51 -0400
Date: Fri, 8 Aug 2003 07:42:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Joel Becker <jlbec@evilplan.org>, Andrew Morton <akpm@osdl.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH][2.6-mm] Readahead issues and AIO read speedup
Message-ID: <20030808054239.GB2886@suse.de>
References: <20030807100120.GA5170@in.ibm.com> <200308070901.01119.pbadari@us.ibm.com> <20030807092800.58335e84.akpm@osdl.org> <20030807193641.GM3164@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807193641.GM3164@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07 2003, Joel Becker wrote:
> On Thu, Aug 07, 2003 at 09:28:00AM -0700, Andrew Morton wrote:
> > If the database pagesize is 16k then the application should be submitting
> > 16k reads, yes?  If so then these should not be creating 4k requests at the
> > device layer!  So what we need to do is to ensure that at least those 16k
> 
> 	Um, I thought bio enforced single CDB I/O for contiguous chunks
> of disk!  If it doesn't, 2.6 is just as lame as 2.4.

It does of course, that was one of the main points of the bio structure.
->readpages() can submit those 16k minimum chunks in one bio.

-- 
Jens Axboe

