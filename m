Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbTHESKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbTHESKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:10:16 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:59128 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S267561AbTHESKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:10:13 -0400
Date: Tue, 5 Aug 2003 12:09:46 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: i_blksize
Message-ID: <20030805120946.Y4479@schatzie.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <UTC200308051627.h75GR7J08241.aeb@smtp.cwi.nl> <20030805105006.2769e44a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030805105006.2769e44a.akpm@osdl.org>; from akpm@osdl.org on Tue, Aug 05, 2003 at 10:50:06AM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 05, 2003  10:50 -0700, Andrew Morton wrote:
> Andries.Brouwer@cwi.nl wrote:
> > Yes. But nevertheless, now that you brought this up,
> > we might consider throwing out i_blksize.
> > 
> > I am not aware of anybody who actually uses this to give
> > per-file advice. So, it could be in the superblock.
> 
> I suppose so.  reiserfs plays with it.
> 
> I can't really see that anyone would want to set the I/O size hint on a
> per-inode basis, especially as the readahead and writebehind code will
> cheerfully ignore it.

Actually, Lustre uses this, because each file can be striped over a
different number of storage targets, and you want read and write requests
large enough to try and write to all of the targets at one time.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

