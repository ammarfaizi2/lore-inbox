Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261871AbTCGXXM>; Fri, 7 Mar 2003 18:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbTCGXXM>; Fri, 7 Mar 2003 18:23:12 -0500
Received: from air-2.osdl.org ([65.172.181.6]:31115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261871AbTCGXXJ>;
	Fri, 7 Mar 2003 18:23:09 -0500
Subject: Re: [PATCH] register_blkdev
From: John Cherry <cherry@osdl.org>
To: Randy Dunlap <rddunlap@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Joel.Becker@oracle.com,
       greg@kroah.com, akpm@digeo.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20030307151744.73738fdd.rddunlap@osdl.org>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl>
	 <20030307193644.A14196@infradead.org>
	 <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com>
	 <20030307225517.GF2835@ca-server1.us.oracle.com>
	 <20030307225710.A18005@infradead.org>
	 <20030307151744.73738fdd.rddunlap@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1047080297.10926.180.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 07 Mar 2003 15:38:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 15:17, Randy.Dunlap wrote:
> On Fri, 7 Mar 2003 22:57:10 +0000 Christoph Hellwig <hch@infradead.org> wrote:
> 
> | On Fri, Mar 07, 2003 at 02:55:18PM -0800, Joel Becker wrote:
> | > On Fri, Mar 07, 2003 at 02:12:17PM -0800, Greg KH wrote:
> | > > On Fri, Mar 07, 2003 at 12:30:29PM -0800, Andrew Morton wrote:
> | > > > 32-bit dev_t is an important (and very late!) thing to get into the 2.5
> | > > > stream.  Can we put this ahead of cleanup stuff?
> | > > 
> | > > Can we get people to agree that this will even go into 2.5, due to the
> | > > lateness of it?  I didn't think it was going to happen.
> 
> Yes from this side of the street.
> 
> | > 	This is essential.  There are installations using >1000 disks
> | 
> | and?  we still have tons of free block majors..
> 
> What has to be done to uses those?  Just grab unassigned majors from devices.txt
> and run with them, or something else?  (as well as mknod's of course)
> Or use devfs?

Sure. You could grab unassigned majors...if that is what you want to
do.  There are a number of ways to "get around" the lack of minor
numbers.  None of them follow conventional thinking with regards to
major/minor usage.

John

> 
> --
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

