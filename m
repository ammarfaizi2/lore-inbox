Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbTCaWrt>; Mon, 31 Mar 2003 17:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261891AbTCaWrt>; Mon, 31 Mar 2003 17:47:49 -0500
Received: from dyn-ctb-210-9-246-105.webone.com.au ([210.9.246.105]:16644 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S261886AbTCaWrs>;
	Mon, 31 Mar 2003 17:47:48 -0500
Message-ID: <3E88C818.1040506@cyberone.com.au>
Date: Tue, 01 Apr 2003 08:58:32 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: cfriesen@nortelnetworks.com, helgehaf@aitel.hist.no, erik@hensema.net,
       linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
References: <200303312251.h2VMp8gv000270@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200303312251.h2VMp8gv000270@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:

>>If the memory does get written to again before the writeout timeout
>>then yeah its used some cpu, memory, pci, etc that it didn't have
>>to.
>>
>
>It will presumably also have filled the cache with the writeout data.
>
What cache?

>
>
>>>Ultimately its all a tradeoff.  Do you write now, or do you hold off 
>>>and hope that you can throw away some of the writes because new stuff 
>>>will home in to overwrite them?
>>>
>>Yes it is a tradeoff. Having an idle disk gives more weight to "write now".
>>
>
>Not necessarily.  What if you are using a solid state disk which only
>allows a relatively low number of re-write cycles?  What if the disk
>is spun down, and spinning it up uses a lot of power?  On a laptop,
>you don't necessarily want the disk spinning up just to write one
>sector.
>
Yes it does. The factors you mention just add (a lot) more
weight to "hold off".

