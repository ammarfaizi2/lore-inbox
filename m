Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbUCKTEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUCKTEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:04:54 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:27343 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S261655AbUCKTEu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:04:50 -0500
Subject: Re: blk_congestion_wait racy?
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, piggin@cyberone.com.au
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFF79FE9F7.73A1504E-ONC1256E54.006825BF-C1256E54.0068C4F9@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 11 Mar 2004 20:04:21 +0100
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 11/03/2004 20:04:22
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> Yes, sorry, all the world's an x86 :( Could you please send me whatever
> diffs were needed to get it all going?

I am just preparing that mail :-)

> I thought you were running a 256MB machine?  Two seconds for 400 megs of
> swapout?  What's up?

Roughly 400 MB of swapout. And two seconds isn't that bad ;-)

> An ouch-per-second sounds reasonable.  It could simply be that the CPUs
> were off running other tasks - those timeout are less than scheduling
> quanta.

I don't understand why an ouch-per-second is reasonable. The mempig is
the only process that runs on the machine and the blk_congestion_wait
uses HZ/10 as timeout value. I'd expect about 100 ouches for the 10
seconds the test runs.

The 4x performance difference remains not understood.


blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


