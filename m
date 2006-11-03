Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752787AbWKCNbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbWKCNbr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 08:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752973AbWKCNbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 08:31:47 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:219 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751676AbWKCNbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 08:31:47 -0500
Date: Fri, 3 Nov 2006 14:31:46 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <20061103122126.GC11947@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.64.0611031428010.17427@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz>
 <20061103101901.GA11947@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0611031252430.17174@artax.karlin.mff.cuni.cz>
 <20061103122126.GC11947@wohnheim.fh-wedel.de>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1908636959-725541422-1162560706=:17427"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1908636959-725541422-1162560706=:17427
Content-Type: TEXT/PLAIN; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

>>> I am fully aware the counters are effectively 48-bit.  If they were
>>> just 32-bit, you would likely have hit the problem yourself already.
>>
>> Given the seek time 0.01s, 31-bit value would last for minimum time of 248
>> days when doing only syncs and nothing else. 47-bit value will last for
>> reasonably long.
>
> So you can at most do one transaction per drive seek?  That would
> definitely solve the overflow case, but hardly sounds like a
> high-performance filesystem. :)

Really it can batch any number of modifications into one transaction 
(unless fsync or sync is called). Transaction is closed only on 
fsync/sync, if 2 minutes pass (can be adjusted) or when the disk runs out 
of space.

Mikulas

Mikulas

> Jörn
>
> -- 
> Data expands to fill the space available for storage.
> -- Parkinson's Law
>

--1908636959-725541422-1162560706=:17427--
