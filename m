Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSG3UzS>; Tue, 30 Jul 2002 16:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSG3UzS>; Tue, 30 Jul 2002 16:55:18 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:16934 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316541AbSG3UzR>; Tue, 30 Jul 2002 16:55:17 -0400
Date: Tue, 30 Jul 2002 15:58:40 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200207302058.PAA92524@tomcat.admin.navo.hpc.mil>
To: mwood@IUPUI.Edu, unlisted-recipients:; (no To-header on input)
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
cc: <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Fri, 19 Jul 2002, Jesse Pollard wrote:
> [snip]
> > In even earlier OSs (DEC RSX, TOPS 10) the file index table was actually a file
> > in the filesystem (usually named index.idx (or was it file.idx...).
> 
> INDEXF.SYS, on TOPS-10.
> 
> >                                                                     I don't
> > know what it was called in MULTICs where the UNIX varient would have
> > started.
> >
> > Most of these filesystems were based on contigeuous allocation, or allocations
> > of contigeous segments.
> 
> "Extents".  "Segments" were contiguous hunks of real memory that the MMU
> knew about, then as now.

I'll accept extents - the "segment" reference was wrong.

> [snip]
> > Note - the version number had nothing to do with the file version -
> > it was used to aid file recovery and was only a reuse count of the index
> > node. The index node contents had to have the same version number as the
> > directory entry, or the directory entry was considered invalid. The
> > file name was a rad50, or sixbit (packed) characters, and sometimes was
> > stored in both inode and directory - again, for rebuilding the file system.
> 
> No, RAD50 and SIXBIT are different.  You can (de)compose SIXBIT words with
> simple shift-and-mask operations, but RAD50 requires arithmetic.  (Hmmm,
> on TOPS-10 we called it RADIX50, so maybe it's different.)

Definitely different. RAD50 was used in FILES-11 and RT-11 disks. It was used
to store 3 characters in a 16 bit word. SIXBIT was used on TOPS-10 36bit
systems to store 6 characters in a word. It also allowed for a fast file
name search since the names were all on word boundaries (full filename
compair took 2 compair, and 1 mask operation 6+3 file names).

> -- 
> Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
> Who just last weekend rediscovered an MF10 core-plane hiding in the filing
> cabinet.

Still got the manuals ? :-)

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
