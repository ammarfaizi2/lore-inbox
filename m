Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSIEOVE>; Thu, 5 Sep 2002 10:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSIEOVE>; Thu, 5 Sep 2002 10:21:04 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:640 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S317590AbSIEOVD>; Thu, 5 Sep 2002 10:21:03 -0400
Date: Thu, 5 Sep 2002 10:25:38 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: invalidate_inode_pages in 2.5.32/3
Message-ID: <Pine.LNX.4.44.0209051023490.5579-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all-

it appears that changes in or around invalidate_inode_pages that went into
2.5.32/3 have broken certain cache behaviors that the NFS client depends
on.  when the NFS client calls invalidate_inode_pages to purge directory
data from the page cache, sometimes it works as before, and sometimes it
doesn't, leaving stale pages in the page cache.

i don't know much about the MM, but i can reliably reproduce the problem.  
what more information can i provide?  please copy me, as i'm not a member 
of the linux-kernel mailing list.

        - Chuck Lever
-- 
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

