Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262561AbSI0TCh>; Fri, 27 Sep 2002 15:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262598AbSI0TCh>; Fri, 27 Sep 2002 15:02:37 -0400
Received: from packet.digeo.com ([12.110.80.53]:19077 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262564AbSI0TCf>;
	Fri, 27 Sep 2002 15:02:35 -0400
Message-ID: <3D94AC8B.4AB6EB09@digeo.com>
Date: Fri, 27 Sep 2002 12:07:55 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doingfile  
 transfers
References: <200209271721.g8RHLTn05231@localhost.localdomain> <2543856224.1033153019@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2002 19:07:48.0149 (UTC) FILETIME=[2B20D650:01C26659]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> 
> ...
> > The evidence is here:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103302456113997&w=1
> 
> Which unfortunately characterizes only a single symptom without breaking
> it down on a transaction by transaction basis.  We need to understand
> how many writes were queued by the OS to the drive between each read to
> know if the drive is actually allowing writes to pass reads or not.
> 

Given that I measured a two-second read latency with four tags,
that would be about 60 megabytes of write traffic after the
read was submitted.  Say, 120 requests.  That's with a tag
depth of four.

Not sure how old the disk is.  It's a 36G Fujitsu SCA-2.  Manufactured
in 2000, perhaps??
