Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263625AbSIQFOT>; Tue, 17 Sep 2002 01:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263627AbSIQFOT>; Tue, 17 Sep 2002 01:14:19 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:19662 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263625AbSIQFOS>; Tue, 17 Sep 2002 01:14:18 -0400
Message-ID: <043801c25e09$c3002b40$1125a8c0@wednesday>
From: "jdow" <jdow@earthlink.net>
To: <root@chaos.analogic.com>
Cc: "jw schultz" <jw@pegasys.ws>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1020916082446.22214A-100000@chaos.analogic.com>
Subject: Re: Heuristic readahead for filesystems
Date: Mon, 16 Sep 2002 22:19:13 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Richard B. Johnson" <root@chaos.analogic.com>

> On Thu, 12 Sep 2002, jdow wrote:

> > Dick, those studies are simply not meaningful. The speedup for
> > general applications that I generated in the mid 80s with a pair
> > of SCSI controllers for the Amiga was rather dramatic. At that
> > time every PC controller I ran down was reading 512 bytes per
> > transaction. They could not read contiguous sectors unless they
> > were VERY fast. For these readahead would generate no benefit.
> > (Even some remarkably expensive SCSI controllers for PCs fell
> > into that trap and defective mindset.) The controllers I re-
> > engineered were capable of reading large blocks of data multiple
> > sectors in size in a single transaction. I experimented with
> > several programs and discovered that a 16k readahead was about
> > my optimum compromise between the read time overhead vs the
> > transaction time overhead. I even found that for the average case
> > ONE buffer was sufficient, which boggled me. (As a developer I
> > was used to reading multiple files at a time to create object
> > files and linked targets.)
> 
> Well they could read contiguous sectors if the sector interleave
> was correctly determined and the correct interleave was set
> while low-level formatting. Now-days, interleave is either ignored
> or unavailable because there is a sector buffer that can contain
> an entire track of data. Some SCSI drives have sector buffers
> that can contain a whole cylinder of data.

Please allow me to add to my previous comment that the StarDrive and
HardFrame controllers were SCSI controllers. They ALWAYS made multi-
block reads. The smallest read they made was 16k. If more was requested
the StarDrive would read as much as was requested in one read. The
HardFrame had to break it into smaller, 128k, pieces due to a strange
DMA problem with the DMA controller that didn't like to be recycled
too quickly. So if a drive could send contiguous sectors on a 1:1
interleave that was what was used. (The ONLY thing I ever had that
could not was an Adaptec A4000 SCSI to ST506 controller that was rather
poorly written inside and could not, itself, manage 1:1 interleave on
the attached ST506 drive.) With CP/M I was doing 1:1 interleave on
8" floppies in the late 70s at last as reliably as other folks did
their 13:1 (CP/M) or 2:1 (UCSD Pascal). The controller was "dump",
a WD 1771 chip in a board called a "VersaFloppy".

{^_^}   Joanne Dow, jdow@earthlink.net, who "gets it off" doing things
        like this that the experts tell her are impossible.


