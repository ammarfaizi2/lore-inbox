Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261983AbTCHBju>; Fri, 7 Mar 2003 20:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261976AbTCHBju>; Fri, 7 Mar 2003 20:39:50 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:19453 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S261975AbTCHBir>; Fri, 7 Mar 2003 20:38:47 -0500
Date: Fri, 7 Mar 2003 17:49:11 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       cherry@osdl.org, rddunlap@osdl.org, greg@kroah.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308014911.GG2835@ca-server1.us.oracle.com>
References: <20030307193644.A14196@infradead.org> <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com> <20030307225517.GF2835@ca-server1.us.oracle.com> <20030307225710.A18005@infradead.org> <20030307151744.73738fdd.rddunlap@osdl.org> <1047080297.10926.180.camel@cherrytest.pdx.osdl.net> <20030307233636.A19260@infradead.org> <20030307154624.12105fa3.akpm@digeo.com> <20030307235454.A19662@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307235454.A19662@infradead.org>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 11:54:54PM +0000, Christoph Hellwig wrote:
> On Fri, Mar 07, 2003 at 03:46:24PM -0800, Andrew Morton wrote:
> > Christoph, it would help this discussion very much if you could tell everyone
> > how we should set about solving the many-disks problem.  In detail.
> 
> Just use blk_register_region() to claim the region you want, you
> don't have to care for any major/minor binary.  There is not much of
> the dev_t space used for block devices at all so there's no problem.

	There are a couple issues with this.  I wasn't aware there were
enough free majors to cover systems with 4000 disks.  Those systems
exist today.  They're only going to grow.
	If you are dynamically building majors, how do you populate
/dev?

Joel

-- 

Life's Little Instruction Book #24

	"Drink champagne for no reason at all."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
