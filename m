Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289859AbSA2UCj>; Tue, 29 Jan 2002 15:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289858AbSA2UCa>; Tue, 29 Jan 2002 15:02:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8464 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289855AbSA2UCP>;
	Tue, 29 Jan 2002 15:02:15 -0500
Message-ID: <3C56FE14.15EA248E@zip.com.au>
Date: Tue, 29 Jan 2002 11:55:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Josh MacDonald <jmacd@CS.Berkeley.EDU>, Alexander Viro <viro@math.psu.edu>,
        Hans Reiser <reiser@namesys.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-list] Re: [reiserfs-dev] Re: Note describing poor dcache 
 utilization under high memory pressure
In-Reply-To: <3C55E9E3.50207@namesys.com> <Pine.GSO.4.21.0201281927320.6592-100000@weyl.math.psu.edu> <20020129092858.D8740@helen.CS.Berkeley.EDU>,
		<20020129092858.D8740@helen.CS.Berkeley.EDU>; from jmacd@CS.Berkeley.EDU on Tue, Jan 29, 2002 at 09:28:58AM -0800 <20020129114415.S763@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> But if it is unused and not recently referenced, there is little benefit
> in keeping it around, is there?

In all of this, please remember that all caches are not of
equal value-per-byte.  A single page contains 32 dentries,
and can thus save up to 32 disk seeks.  It's potentially
a *lot* more valuable than a (single-seek) pagecache page.

Just a thought...

-
