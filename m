Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbSJXVXq>; Thu, 24 Oct 2002 17:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265664AbSJXVXq>; Thu, 24 Oct 2002 17:23:46 -0400
Received: from packet.digeo.com ([12.110.80.53]:60820 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265661AbSJXVXq>;
	Thu, 24 Oct 2002 17:23:46 -0400
Message-ID: <3DB86650.1C48F044@digeo.com>
Date: Thu, 24 Oct 2002 14:29:52 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: chrisl@vmware.com
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021024191531.GD1398@vmware.com> <3DB85C1B.62D14184@digeo.com> <20021024212313.GF1398@vmware.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2002 21:29:52.0855 (UTC) FILETIME=[7D66FE70:01C27BA4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chrisl@vmware.com wrote:
> 
> > on a 2.4 highmem machine can go into a spin, but it will come back
> > to life after several minutes.
> 
> No, it will not come back to life, at least not after several minutes.
> And there is not sign it is going to come back to life.

A 2.5G machine would, iirc, spin for 3-5 minutes.

Umm, probably the time would increase somewhat exponentially
with memory size so yes, you could be in for a very long wait.

-ac kernels have an lru per zone and so would not be bitten
by this failure.  If indeed you are striking this problem,
which is described at
http://mail.nl.linux.org/linux-mm/2002-08/msg00049.html
