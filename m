Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317230AbSFRBqu>; Mon, 17 Jun 2002 21:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSFRBqt>; Mon, 17 Jun 2002 21:46:49 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:28662 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317230AbSFRBqs>; Mon, 17 Jun 2002 21:46:48 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 17 Jun 2002 19:45:13 -0600
To: Andrew Morton <akpm@zip.com.au>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 3x slower file reading oddity
Message-ID: <20020618014513.GK22427@clusterfs.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	dean gaudet <dean-list-linux-kernel@arctic.org>,
	linux-kernel@vger.kernel.org
References: <3D0E7041.860710CA@zip.com.au> <Pine.LNX.4.44.0206171649270.18507-100000@twinlark.arctic.org> <3D0E807C.5D50C17E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D0E807C.5D50C17E@zip.com.au>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 17, 2002  17:36 -0700, Andrew Morton wrote:
> You can probably lessen the seek-rate by accessing the files in the correct
> order.  Read all the files from a directory before descending into any of
> its subdirectories.  Can find(1) do that?  You should be able to pretty
> much achieve disk bandwidth this way - it depends on how bad the inter-
> and intra-file fragmentation has become.

Just FYI - "find -depth" will do that, from find(1):
	-depth Process each directory's contents before the directory itself.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

