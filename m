Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSGJVBQ>; Wed, 10 Jul 2002 17:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSGJVBP>; Wed, 10 Jul 2002 17:01:15 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:63997 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317622AbSGJVBO>; Wed, 10 Jul 2002 17:01:14 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 10 Jul 2002 15:01:53 -0600
To: Marc-Christian Petersen <mcp@linux-systeme.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: htree directory indexing 2.4.18-2 BUG with highmem and also high i/o
Message-ID: <20020710210153.GA1045@clusterfs.com>
Mail-Followup-To: Marc-Christian Petersen <mcp@linux-systeme.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
References: <200207092333.01130.mcp@linux-systeme.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207092333.01130.mcp@linux-systeme.de>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 09, 2002  23:33 +0200, Marc-Christian Petersen wrote:
> Hi Daniel,
> 
> I've found a bug with htree directory indexing patch and
> highmem enabled (64GB). This is with 2.4.18 and htree patch
> 2.4.18-2. Oops appears if accessing an ext2 partition with ls
> or doing "who/w" in the directory of the ext2 partition.

The ext2 htree patch probably needs to add a "kmap()" and "kunmap()"
in the function that reads a page and scans the directory for the
name it is looking for.  I can't be any more specific than this
right now since I only have the ext3 version of this patch, and it
does not have page-cache based directories (it is still using the
buffer cache).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

