Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264803AbRF1WtC>; Thu, 28 Jun 2001 18:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264807AbRF1Wsw>; Thu, 28 Jun 2001 18:48:52 -0400
Received: from m29-mp1-cvx1b.col.ntl.com ([213.104.72.29]:41605 "EHLO
	[213.104.72.29]") by vger.kernel.org with ESMTP id <S264794AbRF1Wsj>;
	Thu, 28 Jun 2001 18:48:39 -0400
To: Jason McMullan <jmcmullan@linuxcare.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <20010626155838.A23098@jmcmullan.resilience.com>
From: John Fremlin <vii@users.sourceforge.net>
Date: 28 Jun 2001 23:47:53 +0100
In-Reply-To: <20010626155838.A23098@jmcmullan.resilience.com> (Jason McMullan's message of "Tue, 26 Jun 2001 15:58:38 -0400")
Message-ID: <m24rt0gr1i.fsf@boreas.yi.org.>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[...]

> 	immediate: RAM, on-chip cache, etc. 
> 	fast:	   Flash reads, ROMs, etc.
> 	medium:    Hard drives, CD-ROMs, 100Mb ethernet, etc.
> 	slow:	   Flash writes, floppy disks,  CD-WR burners
> 	packeted:  Reads/write should be in as large a packet as possible
> 
> Embedded Case

[...]

> Desktop Case

I'm not sure there's any point in separating the cases like this.  The
complex part of the VM is the caching part => to be a good cache you
must take into account the speed of accesses to the cached medium,
including warm up times for sleepy drives etc.

It would be really cool if the VM could do that, so e.g. in the ideal
world you could connect up a slow harddrive and have its contents
cached as swap on your fast harddrive(!) (not a new idea btw and
already implemented elsewhere). I.e. from the point of view of the VM a
computer is just a group of data storage units and it's allowed to use
up certain parts of each one to do stuff

[...]

-- 

	http://ape.n3.net
