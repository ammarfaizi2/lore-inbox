Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289749AbSAWJc2>; Wed, 23 Jan 2002 04:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289750AbSAWJcT>; Wed, 23 Jan 2002 04:32:19 -0500
Received: from int-mail.syd.fl.net.au ([202.181.0.28]:22545 "HELO
	delenn.fl.net.au") by vger.kernel.org with SMTP id <S289749AbSAWJcK>;
	Wed, 23 Jan 2002 04:32:10 -0500
From: "Duraid Madina" <duraid@fl.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: VM: Where do we stand?
Date: Wed, 23 Jan 2002 20:32:03 +1100
Message-ID: <000901c1a3f0$d2e44ba0$022a17ac@simplex>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sure at least some of you will immediately recognize these words:

>
>Swap allocation is terrible.  Linux uses a linear array which it scans
>looking for a free swap block.  It does a relatively simple swap
>cluster cache, but eats the full linear scan if that fails which can be
>terribly nasty.  The swap clustering algorithm is a piece of crap, 
>too -- once swap becomes fragmented, the linux swapper falls on its
face.
>
>It does read-ahead based on the swapblk which wouldn't be bad if it
>clustered writes by object or didn't have a fragmentation problem.
>As it stands, their read clustering is useless.  Swap deallocation is 
>fast since they are using a simple reference count array.
>
>File read-ahead is half-hazard at best.
>
>The paging queues ( determing the age of the page and whether to 
>free or clean it) need to be written... the algorithms being used
>are terrible.
>
> * For the nominal page scan, it is using a one-hand clock algorithm.  
>   All I can say is:  Oh my god!  Are they nuts?  That was abandoned
>   a decade ago.  The priority mechanism they've implemented is nearly
>   useless.
>
> * To locate pages to swap out, it takes a pass through the task list. 
>   Ostensibly it locates the task with the largest RSS to then try to
>   swap pages out from rather then select pages that are not in use.
>   From my read of the code, it also botches this badly.
>
>Linux does not appear to do any page coloring whatsoever, but it would
>not be hard to add it in.
>

	Where does Linux stand, three years on? An O(1) scheduler is
nice, but I tell you what'd be even nicer...

	coming out for some food, (it's dark out)
	Duraid


