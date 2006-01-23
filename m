Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWAWTwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWAWTwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWAWTwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:52:22 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:46292 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932463AbWAWTwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:52:21 -0500
In-Reply-To: <43D28189.3080407@argo.co.il>
To: Avi Kivity <avi@argo.co.il>
Cc: Al Boldi <a1426z@gawab.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [RFC] VM: I have a dream...
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF9B696195.5A30AEF3-ON882570FF.006879C2-882570FF.006D26D2@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Mon, 23 Jan 2006 11:52:13 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0HF124 | January 12, 2006) at
 01/23/2006 14:52:14,
	Serialize complete at 01/23/2006 14:52:14
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Perhaps you'd be interested in single-level store architectures, where 
>no distinction is made between memory and storage. IBM uses it in one 
>(or maybe more) of their systems.

It's the IBM Eserver I Series, nee System/38 (A.D. 1980), aka AS/400.

It was expected at one time to be the next generation of computer 
architecture, but it turned out that the computing world had matured to 
the point that it was more important to be backward compatible than to 
push frontiers.

The single 128 bit address space addresses every byte of information in 
the system.  The underlying system keeps the majority of it on disk, and 
the logic that loads stuff into electronic memory when it has to be there 
is below the level that any ordinary program would see, much like the 
logic in an IA32 CPU that loads stuff into processor cache.  It's worth 
noting that nowhere in an I Series machine is a layer that looks like a 
CPU Linux runs on; it's designed for single level storage from the gates 
on up through the operating system.

I found Al's dream rather vague, which explains why several people 
inferred different ideas from it (and then beat them down).  It sort of 
sounds like single level storage, but also like virtual memory and like 
mmap.  I assume it's actually supposed to be something different from all 
those.

I personally have set my sights further down the road: I want an address 
space that addresses every byte of information in the universe, not just 
"in" a computer system.  And the infrastructure should move it around 
among various media for optimal access without me worrying about it.

--
Bryan Henderson                     IBM Almaden Research Center
San Jose CA                         Filesystems

