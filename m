Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265514AbUEZMDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbUEZMDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265518AbUEZMDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:03:41 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:62618 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265514AbUEZMDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:03:39 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Denis Vlasenko'" <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 05:07:18 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200405261341.10384.vda@port.imtp.ilyichevsk.odessa.ua>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDD2h/EfcG8W9IQpacGAKTbA4NgAACB9Jg
Message-Id: <S265514AbUEZMDj/20040526120339Z+1733@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

640k? who wrote that?

In the last three years, I have witnessed many large Oracle databases where
the maximum SGA size of roughly 4GB + all shadow processes, parallel slaves,
dbwr, etc.. all run completely within physical memory with the most
aggressive settings available. Previously, Oracle databases were much
smaller, but I never saw databases sized this way such that they could exist
entirely in physical memory. 

In fact, the SGA is commonly configured to use large 4m, locked pages (ISM
in Solaris, not sure if hugepages are swappable in linux) that couldn't be
swapped to disk even if you wanted to.

Again, we are not talking about the bloatware that is developed using some
rad tool for a workstation that has continued to grow over the years. I am
talking about where the industry is dumping tons of money on performance
where it really, really counts. The middle-ware that connects to a database
may continue to grow in terms of bloat, but people are happily scaling those
environments horizontally in most cases. The biggest performance problems to
solve (that people care about and are willing to pay $$ to solve) are for
the large databases that run Corporate America. There are certainly
scientific applications where performance is critical and there are dollars
to fund improvement as well, but their numbers don't compare to the number
of Oracle instances out there running in the Enterprise.

Optimizing the performance of swap operations for even a small tradeoff in
performance for memory operations that take place entirely in physical
memory is just a broke minded, brain dead direction in the year 2004 IMHO.

--Buddy   






-----Original Message-----
From: Denis Vlasenko [mailto:vda@port.imtp.ilyichevsk.odessa.ua] 
Sent: Wednesday, May 26, 2004 3:41 AM
To: Buddy Lumpkin; 'William Lee Irwin III'
Cc: orders@nodivisions.com; linux-kernel@vger.kernel.org
Subject: RE: why swap at all?

On Wednesday 26 May 2004 11:30, Buddy Lumpkin wrote:
> I have worked at large fortune 500 companies with deep pockets though, so
> this may not be the case for many. I make this point though because I
think
> if it isn't the case yet, it will be in the near future as memory becomes
> even cheaper because the trend certainly exists.

"640k will be enough for anyone" ?

No. Unfortunately, userspace programs grow in size as fast
as your RAM. Because typically developers do not think
about size of their program until it starts to outgrow
their RAM.

Today, 128M RAM swapless is barely enough to run full
spectrum of apps. OpenOffice and Mozilla "lead" the pack,
followed by KDE/Gnome etc.
-- 
vda

