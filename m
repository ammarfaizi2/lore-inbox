Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319499AbSILV2W>; Thu, 12 Sep 2002 17:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319500AbSILV2W>; Thu, 12 Sep 2002 17:28:22 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:16043 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S319499AbSILV2T>; Thu, 12 Sep 2002 17:28:19 -0400
Message-ID: <002a01c25aa3$f865b7a0$1125a8c0@wednesday>
From: "jdow" <jdow@earthlink.net>
To: <root@chaos.analogic.com>, "jw schultz" <jw@pegasys.ws>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1020912072949.2700A-100000@chaos.analogic.com>
Subject: Re: Heuristic readahead for filesystems
Date: Thu, 12 Sep 2002 14:33:01 -0700
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

> Then you are tuning a file-system for a single program
> like `ls`. Most real-world I/O to file-systems are not done
> by `ls` or even `make`. The extra read-ahead overhead is
> just that, 'overhead'. Since the cost of disk I/O is expensive,
> you certainly do not want to read any more than is absolutely
> necessary. There had been a lot so studies about this in the
> 70's when disks were very, very, slow. The disk-to-RAM speed
> ratio hasn't changed much even though both are much faster.
> Therefore, the conclusions of these studies, made by persons
> from DEC and IBM, should not have changed. From what I recall,
> all studies showed that read-ahead always reduced performance,
> but keeping what was already read in RAM always increased
> performance.

Dick, those studies are simply not meaningful. The speedup for
general applications that I generated in the mid 80s with a pair
of SCSI controllers for the Amiga was rather dramatic. At that
time every PC controller I ran down was reading 512 bytes per
transaction. They could not read contiguous sectors unless they
were VERY fast. For these readahead would generate no benefit.
(Even some remarkably expensive SCSI controllers for PCs fell
into that trap and defective mindset.) The controllers I re-
engineered were capable of reading large blocks of data multiple
sectors in size in a single transaction. I experimented with
several programs and discovered that a 16k readahead was about
my optimum compromise between the read time overhead vs the
transaction time overhead. I even found that for the average case
ONE buffer was sufficient, which boggled me. (As a developer I
was used to reading multiple files at a time to create object
files and linked targets.)

Back in the 70s did anyone ever read more than a single block
at a time, other than me that is? (I had readahead in CP/M back
in the late 70s. But the evidence for that has evaporated I am
afraid. I repeatedly boggled other CP/M users with my 8" floppy
speeds as a result. I also added blocking and deblocking so I
could use large sectors for even more speed.)

{^_^}   Joanne Dow, jdow@earthlink.net, not a gray beard solely
        because I am severely beard challenged.


