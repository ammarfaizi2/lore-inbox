Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbSJXUkO>; Thu, 24 Oct 2002 16:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265659AbSJXUkO>; Thu, 24 Oct 2002 16:40:14 -0400
Received: from packet.digeo.com ([12.110.80.53]:49042 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265657AbSJXUkN>;
	Thu, 24 Oct 2002 16:40:13 -0400
Message-ID: <3DB85C1B.62D14184@digeo.com>
Date: Thu, 24 Oct 2002 13:46:19 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: chrisl@vmware.com
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021024191531.GD1398@vmware.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2002 20:46:19.0247 (UTC) FILETIME=[67920FF0:01C27B9E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chrisl@vmware.com wrote:
> 
> ...
> See the comment at the source for parameter. basically, if you want
> 3 virtual machine, each have 2 process, using 1 G ram each you can do:
> 
> bigmm -i 3 -t 2 -c 1024
> 
> I run it on two 4G and 8G smp machine. Both can dead lock if I mmap
> enough memory.
> 

Are you sure it's a deadlock?  A large MAP_SHARED load like this
on a 2.4 highmem machine can go into a spin, but it will come back
to life after several minutes.
