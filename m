Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262005AbTCHCca>; Fri, 7 Mar 2003 21:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbTCHCca>; Fri, 7 Mar 2003 21:32:30 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:12708 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S262005AbTCHCc2>; Fri, 7 Mar 2003 21:32:28 -0500
Date: Fri, 7 Mar 2003 18:42:50 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@digeo.com>, cherry@osdl.org, rddunlap@osdl.org,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308024249.GI2835@ca-server1.us.oracle.com>
References: <20030308021505.GH2835@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303071816270.2204-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303071816270.2204-100000@home.transmeta.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 06:18:19PM -0800, Linus Torvalds wrote:
> And realize that these things are often limited by on-disk / wire
> representations. Some of which are easier to fix than others (ie, think 
> about NFS servers running old versions of Linux).

	Yeah, I was chatting with Peter about that last night (he was
advocating 64 bits for dev_t).  For some things (NFSv2) we could merely
truncate the space.  It only really matters if /dev is on NFS, and we
can perhaps say "You need NFSv3 or better if you want the larger dev
space".  That's just one possible way to approach it.  A system big
enough to have 5000 disks attached likely isn't getting /dev from an
NFSv2 server.
	I'm so-so on the 64bit vs 32bit dev_t argument, but I'd bet we
only want to change it once for the internal representation.  How we
handle external representations (on disk, over the wire) is a different
matter.

Joel

-- 

"The one important thing i have learned over the years is the difference
 between taking one's work seriously and taking one's self seriously.  The
 first is imperative and the second is disastrous."
	-Margot Fonteyn

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
